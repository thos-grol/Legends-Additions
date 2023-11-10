::ModSoundTest <- {
	ID = "mod_sound_test"
	Name = "ModSoundTest"
	Version = "1.0.0"
	JSHandle = null
	function connect()
	{
		this.JSHandle = this.UI.connect(this.ID, this);
	}
	function destroy()
	{
		this.JSHandle = ::UI.disconnect(this.JSHandle);
	}
	function isConnected()
	{
		return this.JSHandle != null;
	}
	function onButtonClicked()
	{
		::Sound.play("sounds/ui/click.wav", 1.5);
	}
	function onHover()
	{
		::Sound.play("sounds/ui/hover.wav", 0.8);
	}
	function registerMenuButtons()
	{
		::ModSoundTest.JSHandle.asyncCall("registerMenuButtons", null)
	}
}
::mods_registerMod(::ModSoundTest.ID, ::ModSoundTest.Version, ::ModSoundTest.Name);

::mods_queue(::ModSoundTest.ID, ">mod_msu", function()
{
	::MSU.UI.registerConnection(::ModSoundTest);
	::MSU.UI.addOnConnectCallback(::ModSoundTest.registerMenuButtons);
	::mods_registerJS(::ModSoundTest.ID + ".js");
})
