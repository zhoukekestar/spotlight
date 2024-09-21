use framework "Foundation"
use framework "Vision"
use scripting additions

set gotText to captureImage()

on captureImage()
	set tempFolder to current application's NSTemporaryDirectory()
	set tempImage to tempFolder's stringByAppendingPathComponent:"OCR Temp Image.png"
	set fileManager to current application's NSFileManager's defaultManager()

	-- 螢幕截圖並保存為文件
	do shell script "screencapture -ioxa " & quoted form of (tempImage as text)

	try
		set originalText to recognitionText(tempImage)
		(fileManager's removeItemAtPath:tempImage |error|:(missing value))

		--將文字傳入可編輯對話框
		set editedText to displayEditableDialog(originalText)

		-- 將結果放入剪貼板
		set thePasteboard to current application's NSPasteboard's generalPasteboard()
		thePasteboard's clearContents()
		thePasteboard's setString:editedText forType:(current application's NSPasteboardTypeString)

		return editedText
	on error
		display alert "error" message "no text found"
		(fileManager's removeItemAtPath:tempImage |error|:(missing value))
		return missing value
	end try
end captureImage

on recognitionText(theImage)
	set theImage to current application's |NSURL|'s fileURLWithPath:theImage
	set requestHandler to current application's VNImageRequestHandler's alloc()'s initWithURL:theImage options:(missing value)
	set theRequest to current application's VNRecognizeTextRequest's alloc()'s init()
	--設定辨識語言
	theRequest's setRecognitionLanguages:{"zh-Hant", "en"}
	theRequest's setUsesLanguageCorrection:false
	requestHandler's performRequests:(current application's NSArray's arrayWithObject:(theRequest)) |error|:(missing value)
	set theResults to theRequest's results()
	set theArray to current application's NSMutableArray's new()
	repeat with aResult in theResults
		(theArray's addObject:(((aResult's topCandidates:1)'s objectAtIndex:0)'s |string|()))
	end repeat
	return (theArray's componentsJoinedByString:linefeed) as text
end recognitionText

-- 顯示帶有輸入框的對話框
on displayEditableDialog(defaultText)
	set dialogResult to display dialog "" default answer defaultText buttons {"OK"} default button "OK" with title "Result"

	-- 取得編輯後的文本
	set editedText to text returned of dialogResult
	return editedText
end displayEditableDialog
