//Credit: Taroeld for the base and proving the concept. I only did a few modifications
var ModSoundTest =
{
	mSQHandle : null,
	mModID : "mod_sound_test",
    mID : "mod_sound_test",
    isConnected : function ()
	{
		return this.mSQHandle !== null;
	},
	onConnection : function (_handle)
	{
		this.mSQHandle = _handle
	},
	onDisconnection : function ()
	{
		this.mSQHandle = null;
	},
	registerMenuButtons : function()
	{
		$('[class*="button"]').each(function(){
			if ($(this).data("SoundRegistered") !== true){
				$(this).on("click", function(_event){
					SQ.call(ModSoundTest.mSQHandle, 'onButtonClicked');
				})
				$(this).on("mouseenter", function(_event){
					SQ.call(ModSoundTest.mSQHandle, 'onHover');
				})
			}
		})
	}
};
ModSoundTest.createTextButton = $.fn.createTextButton;
$.fn.createTextButton = function (_text, _callback, _classes, _size, _imagePath)
{
	var ret = ModSoundTest.createTextButton.call(this, _text, _callback, _classes, _size, _imagePath);
	ret.data("SoundRegistered", true);
	ret.on("click", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onButtonClicked');
	})
	ret.on("mouseenter", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onHover');
	})
	return ret;
}

ModSoundTest.createCustomButton = $.fn.createCustomButton;
$.fn.createCustomButton = function(_content, _callback, _classes, _size)
{
	var ret = ModSoundTest.createCustomButton.call(this, _content, _callback, _classes, _size);
	ret.data("SoundRegistered", true);
	ret.on("click", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onButtonClicked');
	})
	ret.on("mouseenter", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onHover');
	})
	return ret;
}

ModSoundTest.createTabTextButton = $.fn.createTabTextButton;
$.fn.createTabTextButton = function (_text, _callback, _classes, _groupName, _size)
{
	var ret = ModSoundTest.createTabTextButton.call(this, _text, _callback, _classes, _groupName, _size);
	ret.data("SoundRegistered", true);
	ret.on("click", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onButtonClicked');
	})
	ret.on("mouseenter", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onHover');
	})
	return ret;
}

ModSoundTest.createImageButton = $.fn.createImageButton;
$.fn.createImageButton = function (_imagePath, _callback, _classes, _size)
{
	var ret = ModSoundTest.createImageButton.call(this, _imagePath, _callback, _classes, _size);
	ret.data("SoundRegistered", true);
	ret.on("click", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onButtonClicked');
	})
	ret.on("mouseenter", function(_event){
		SQ.call(ModSoundTest.mSQHandle, 'onHover');
	})
	return ret;
}

registerScreen("mod_sound_test", ModSoundTest);