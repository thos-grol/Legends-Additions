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
	setCallbacks : function(_obj){
		_obj.on("click", function(){
			SQ.call(ModSoundTest.mSQHandle, 'onButtonClicked');
		})
		_obj.on("mouseenter", function(){
			SQ.call(ModSoundTest.mSQHandle, 'onHover')
		})
	},
	registerMenuButtons : function()
	{
		$('[class*="button"]').each(function(){
			if ($(this).data("SoundRegistered") !== true){
				ModSoundTest.setCallbacks($(this));
			}
		})
		Screens.MainMenuScreen.getModule("MainMenuModule").show = ModSoundTest.MainMenuScreen_show;
	},
	wrapper : function(_func)
	{
		return function()
		{
			var ret = _func.apply(this, arguments);
			ret.data("SoundRegistered", true);
			ModSoundTest.setCallbacks(ret);
			return ret;	
		}
	}
};

$.fn.createTextButton = ModSoundTest.wrapper($.fn.createTextButton);
$.fn.createCustomButton = ModSoundTest.wrapper($.fn.createCustomButton);
$.fn.createTabTextButton = ModSoundTest.wrapper($.fn.createTabTextButton);
$.fn.createImageButton = ModSoundTest.wrapper($.fn.createImageButton);
ModSoundTest.MainMenuScreen_show = Screens.MainMenuScreen.getModule("MainMenuModule").show;
Screens.MainMenuScreen.getModule("MainMenuModule").show = function(_animation)
{
	ModSoundTest.registerMenuButtons();
	return ModSoundTest.MainMenuScreen_show.call(this, _animation);
}
registerScreen("mod_sound_test", ModSoundTest);	