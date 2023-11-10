::mods_hookExactClass("states/main_menu_state", function (o)
{
	local campaign_menu_module_onLoadPressed = o.campaign_menu_module_onLoadPressed;
	o.campaign_menu_module_onLoadPressed = function(_campaignFileName)
	{
		::Z.Lib.play_start();
		campaign_menu_module_onLoadPressed(_campaignFileName);
	}

	local campaign_menu_module_onStartPressed = o.campaign_menu_module_onStartPressed;
	o.campaign_menu_module_onStartPressed = function(_settings)
	{
		::Z.Lib.play_start();
		campaign_menu_module_onStartPressed(_settings);
	}

});

// ::mods_hookExactClass("ui/screens/menu/modules/new_campaign_menu_module", function (o)
// {
// 	local onStartButtonPressed = o.onStartButtonPressed;
// 	o.onStartButtonPressed = function( _settings )
// 	{
// 		::Z.Lib.play_start();
// 		onStartButtonPressed( _settings );
// 	}

// });