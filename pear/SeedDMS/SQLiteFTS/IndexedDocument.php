<?php
/**
 * Implementation of an indexed document
 *
 * @category   DMS
 * @package    SeedDMS_SQLiteFTS
 * @license    GPL 2
 * @version    @version@
 * @author     Uwe Steinmann <uwe@steinmann.cx>
 * @copyright  Copyright (C) 2010, Uwe Steinmann
 * @version    Release: 1.0.7
 */

/**
 * @uses SeedDMS_SQLiteFTS_Document
 */
require_once('Document.php');  


/**
 * Class for managing an indexed document.
 *
 * @category   DMS
 * @package    SeedDMS_SQLiteFTS
 * @version    @version@
 * @author     Uwe Steinmann <uwe@steinmann.cx>
 * @copyright  Copyright (C) 2011, Uwe Steinmann
 * @version    Release: 1.0.7
 */
class SeedDMS_SQLiteFTS_IndexedDocument extends SeedDMS_SQLiteFTS_Document {

	/* static function execWithTimeout($cmd, $timeout=2) {
		$descriptorspec = array(
			0 => array("pipe", "r"),
			1 => array("pipe", "w"),
			2 => array("pipe", "w")
		);
		$pipes = array();
	 
		$timeout += time();
		$process = proc_open($cmd, $descriptorspec, $pipes);
		if (!is_resource($process)) {
			throw new Exception("proc_open failed on: " . $cmd);
		}
			 
		$output = '';
		$timeleft = $timeout - time();
		$read = array($pipes[1]);
		$write = NULL;
		$exeptions = NULL;
		do {
			stream_select($read, $write, $exeptions, $timeleft, 200000);
					 
			if (!empty($read)) {
				$output .= fread($pipes[1], 8192);
			}
			$timeleft = $timeout - time();
		} while (!feof($pipes[1]) && $timeleft > 0);
 
		if ($timeleft <= 0) {
			proc_terminate($process);
			throw new Exception("command timeout on: " . $cmd);
		} else {
			return $output;
		}
	} */
    
    // yulifu 2017-06-03 改动
    static function execWithTimeout($cmd, $timeout=2) {
        $descriptorspec = array(
            0 => array("pipe", "r"),
            1 => array("pipe", "w"),
            //2 => array("pipe", "w")
            2 => array("file", "./../data/seed-error-output.txt", "a")
        );
        $pipes = array();
     
        $timeout += time();
        $process = proc_open($cmd, $descriptorspec, $pipes);
        if (!is_resource($process)) {
            return '';
        }
             
        $output = '';
        $timeleft = $timeout - time();
        $read = array($pipes[1]);
        $write = NULL;
        $exeptions = NULL;
        do {
            stream_select($read, $write, $exeptions, $timeleft, 200000);
                     
            if (!empty($read)) {
                $output .= fread($pipes[1], 8192);
            }
            $timeleft = $timeout - time();
        } while (!feof($pipes[1]) && $timeleft > 0);

        fclose($pipes[1]);
        fclose($pipes[0]);
        
        if ($timeleft <= 0) {
            proc_terminate($process);
            
        } else {
            proc_close($process);
        }
        
        return $output;
    }

	/**
	 * Constructor. Creates our indexable document and adds all
	 * necessary fields to it using the passed in document
	 */
	public function __construct($dms, $document, $convcmd=null, $nocontent=false, $timeout=5) {
		$_convcmd = array(
			'application/pdf' => 'pdftotext -enc UTF-8 -nopgbrk %s - |sed -e \'s/ [a-zA-Z0-9.]\{1\} / /g\' -e \'s/[0-9.]//g\'',
			'application/postscript' => 'ps2pdf14 %s - | pdftotext -enc UTF-8 -nopgbrk - - | sed -e \'s/ [a-zA-Z0-9.]\{1\} / /g\' -e \'s/[0-9.]//g\'',
			'application/msword' => 'catdoc %s',
			'application/vnd.ms-excel' => 'ssconvert -T Gnumeric_stf:stf_csv -S %s fd://1',
			'audio/mp3' => "id3 -l -R %s | egrep '(Title|Artist|Album)' | sed 's/^[^:]*: //g'",
			'audio/mpeg' => "id3 -l -R %s | egrep '(Title|Artist|Album)' | sed 's/^[^:]*: //g'",
			'text/plain' => 'cat %s',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => '',
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => ''
		);
		if($convcmd) {
			//$_convcmd = $convcmd;
		}

		$version = $document->getLatestContent();
		$this->addField('document_id', $document->getID());
		if($version) {
			$this->addField('mimetype', $version->getMimeType());
			$this->addField('origfilename', $version->getOriginalFileName());
			if(!$nocontent)
				$this->addField('created', $version->getDate(), 'unindexed');
			if($attributes = $version->getAttributes()) {
				foreach($attributes as $attribute) {
					$attrdef = $attribute->getAttributeDefinition();
					if($attrdef->getValueSet() != '')
						$this->addField('attr_'.str_replace(' ', '_', $attrdef->getName()), $attribute->getValue());
					else
						$this->addField('attr_'.str_replace(' ', '_', $attrdef->getName()), $attribute->getValue());
				}
			}
		}
		$this->addField('title', $document->getName());
		if($categories = $document->getCategories()) {
			$names = array();
			foreach($categories as $cat) {
				$names[] = $cat->getName();
			}
			$this->addField('category', implode(' ', $names));
		}
		if($attributes = $document->getAttributes()) {
			foreach($attributes as $attribute) {
				$attrdef = $attribute->getAttributeDefinition();
				if($attrdef->getValueSet() != '')
					$this->addField('attr_'.str_replace(' ', '_', $attrdef->getName()), $attribute->getValue());
				else
					$this->addField('attr_'.str_replace(' ', '_', $attrdef->getName()), $attribute->getValue());
			}
		}

		$owner = $document->getOwner();
		$this->addField('owner', $owner->getLogin());
		if($keywords = $document->getKeywords()) {
			$this->addField('keywords', $keywords);
		}
		if($comment = $document->getComment()) {
			$this->addField('comment', $comment);
		}
		if($version && !$nocontent) {
			$path = $dms->contentDir . $version->getPath();
			$content = '';
			$fp = null;
			$mimetype = $version->getMimeType();
            
            //file_put_contents('./../data/type.txt', $mimetype);
            
			if(isset($_convcmd[$mimetype])) {
                // 2017-06-03 yulifu 修改
                if('text/plain' === $mimetype) {
                    $handle = fopen($path, "r");
                    $content = fread($handle, '8192');  // 8K
                    fclose($handle);
                    
                } else if('application/msword' === $mimetype) {
                    // windows
                    try {
                        $word = new COM('word.application');
                        $word->Visible = 0;
                        $word->Documents->Open($path);
                        $content= $word->ActiveDocument->content->Text;
                        $word->Quit();
                        $word = null;
                        
                        $content = mb_substr($content, 0, 8192);
                        //file_put_contents('./../data/word.txt', $content);
                    
                    } catch(Exception $e) {
                        file_put_contents('./../data/worderr.txt', $e->getMessage());
                    }
                
                } else if('application/vnd.openxmlformats-officedocument.wordprocessingml.document' === $mimetype) {
                    // word
                    include './../vendor/autoload.php';
                    try {                    
                        $writers = array(
                            'Word2007' => 'docx',
                            'ODText' => 'odt',
                            'RTF' => 'rtf',
                            'HTML' => 'html',
                            'PDF' => null);
                        $phpWord = \PhpOffice\PhpWord\IOFactory::load($path);
                        $objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'HTML');
                        
                        $content = $objWriter->getWriterPart('BODY')->write();
                        $content = strip_tags($content);
                        
                        $content = mb_substr($content, 0, 8192);
                        
                        //file_put_contents('./../data/word.txt', $content);
                        
                    } catch(Exception $e) {
                        file_put_contents('./../data/worderr.txt', $e->getMessage());
                    }
                
                } else if('application/vnd.ms-excel' === $mimetype) {
                    
                    try {
                        require_once('PHPExcel/PHPExcel/Reader/Excel5.php');
                        $objReader = new PHPExcel_Reader_Excel5;
                        $objPHPExcel = $objReader->load($path);
                        $sheet = $objPHPExcel->getSheet(0);
                        $highestRow = $sheet->getHighestRow();
                        $highestColumm = $sheet->getHighestColumn();
                        for($row = 1; $row <= $highestRow; $row++){
                            if($row > 100) break;
                            
                            $content .= $sheet->getCell('A'.$row)->getValue();
                        }
                        
                    } catch(Exception $e) {
                        file_put_contents('./../data/excelerr.txt', $e->getMessage());
                    }

                    //file_put_contents('./../data/excel03.txt', $content);
                    
                } else if('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' === $mimetype) {
                    
                    try {
                        require_once('PHPExcel/PHPExcel/Reader/Excel2007.php');
                        $objReader = new PHPExcel_Reader_Excel2007;
                        $objPHPExcel = $objReader->load($path);
                        $sheet = $objPHPExcel->getSheet(0);
                        $highestRow = $sheet->getHighestRow();
                        $highestColumm = $sheet->getHighestColumn();
                        for($row = 1; $row <= $highestRow; $row++){
                            if($row > 100) break;
                            
                            $content .= $sheet->getCell('A'.$row)->getValue();
                        }
                        
                    } catch(Exception $e) {
                        file_put_contents('./../data/excelerr.txt', $e->getMessage());
                    }

                    //file_put_contents('./../data/excel07.txt', $content);
                }
                
                if($content) {
                    $this->addField('content', $content, 'unstored');
                }
                
                /*
				$cmd = sprintf($_convcmd[$mimetype], $path);
				try {
					$content = self::execWithTimeout($cmd, $timeout);
					if($content) {
						$this->addField('content', $content, 'unstored');
					}
				} catch (Exception $e) {
				}
                */
			}
		}
	}
}
?>
