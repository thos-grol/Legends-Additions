this.main_menu_screen <- {
	m = {
		JSHandle = null,
		MainMenuModule = null,
		LoadCampaignModule = null,
		NewCampaignModule = null,
		ScenarioMenuModule = null,
		OptionsMenuModule = null,
		CreditsModule = null,
		Visible = null,
		OnConnectedListener = null,
		OnDisconnectedListener = null,
		OnScreenShownListener = null,
		OnScreenHiddenListener = null
	},
	function isVisible()
	{
		return this.m.Visible != null && this.m.Visible == true;
	}

	function isAnimating()
	{
		return this.m.MainMenuModule.isAnimating() || this.m.ScenarioMenuModule.isAnimating() || this.m.OptionsMenuModule.isAnimating() || this.m.LoadCampaignModule.isAnimating() || this.m.CreditsModule.isAnimating();
	}

	function isMainMenuVisible()
	{
		return this.m.MainMenuModule.isVisible();
	}

	function isLoadCampaignMenuVisible()
	{
		return this.m.LoadCampaignModule.isVisible();
	}

	function isScenarioMenuVisible()
	{
		return this.m.ScenarioMenuModule.isVisible();
	}

	function isOptionsMenuVisible()
	{
		return this.m.OptionsMenuModule.isVisible();
	}

	function getMainMenuModule()
	{
		return this.m.MainMenuModule;
	}

	function getLoadCampaignMenuModule()
	{
		return this.m.LoadCampaignModule;
	}

	function getNewCampaignMenuModule()
	{
		return this.m.NewCampaignModule;
	}

	function getScenarioMenuModule()
	{
		return this.m.ScenarioMenuModule;
	}

	function getOptionsMenuModule()
	{
		return this.m.OptionsMenuModule;
	}

	function getCreditsModule()
	{
		return this.m.CreditsModule;
	}

	function setOnConnectedListener( _listener )
	{
		this.m.OnConnectedListener = _listener;
	}

	function setOnDisconnectedListener( _listener )
	{
		this.m.OnDisconnectedListener = _listener;
	}

	function setOnScreenShownListener( _listener )
	{
		this.m.OnScreenShownListener = _listener;
	}

	function setOnScreenHiddenListener( _listener )
	{
		this.m.OnScreenHiddenListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnConnectedListener = null;
		this.m.OnDisconnectedListener = null;
		this.m.OnScreenShownListener = null;
		this.m.OnScreenHiddenListener = null;
	}

	function create()
	{
		this.m.Visible = false;
		this.m.MainMenuModule = ::new("scripts/ui/screens/menu/modules/main_menu_module");
		this.m.LoadCampaignModule = ::new("scripts/ui/screens/menu/modules/load_campaign_menu_module");
		this.m.NewCampaignModule = ::new("scripts/ui/screens/menu/modules/new_campaign_menu_module");
		this.m.ScenarioMenuModule = ::new("scripts/ui/screens/menu/modules/scenario_menu_module");
		this.m.OptionsMenuModule = ::new("scripts/ui/screens/menu/modules/options_menu_module");
		this.m.CreditsModule = ::new("scripts/ui/screens/menu/modules/credits_module");
	}

	function connect()
	{
		this.m.JSHandle = this.UI.connect("MainMenuScreen", this);
		this.m.MainMenuModule.connectUI(this.m.JSHandle);
		this.m.LoadCampaignModule.connectUI(this.m.JSHandle);
		this.m.NewCampaignModule.connectUI(this.m.JSHandle);
		this.m.ScenarioMenuModule.connectUI(this.m.JSHandle);
		this.m.OptionsMenuModule.connectUI(this.m.JSHandle);
		this.m.CreditsModule.connectUI(this.m.JSHandle);
		this.m.JSHandle.asyncCall("setVersion", [
			this.GameInfo.getVersionNumber() + " " + this.GameInfo.getVersionName() + "Legends Additions " + ::LA.Version,
			"Legends Mod " + ::Legends.Version + " " + ::Legends.BuildName,
		]);
		local dlc = [];

		for( local i = 0; i < 32; i = i )
		{
			if (::Const.DLC.Info[i] != null && ::Const.DLC.Info[i].Announce == true)
			{
				local hasDLC = (::Const.DLC.Mask & 1 << i) != 0;
				dlc.push({
					Image = hasDLC ? ::Const.DLC.Info[i].Icon : ::Const.DLC.Info[i].IconDisabled,
					Tooltip = "dlc_" + i,
					URL = ::Const.DLC.Info[i].URL
				});
			}

			i = ++i;
		}

		this.m.JSHandle.asyncCall("setDLC", dlc);
		local missingFiles = this.checkForRequiredFiles();
		local test = false;

		if (!::Const.DLC.Unhold || !::Const.DLC.Wildmen || !::Const.DLC.Desert || missingFiles.len() > 0)
		{
			local disabledMotdText = "You are missing critical files!";

			if (!::Const.DLC.Unhold || !::Const.DLC.Wildmen || !::Const.DLC.Desert)
			{
				disabledMotdText = disabledMotdText + "\nLegends extensively uses features and assets from all official DLC. We would not be able to offer this mod experience without all the awesome work from Overhype.";
			}

			if (!::Const.DLC.Unhold)
			{
				disabledMotdText = disabledMotdText + "\nMissing \'Beasts and Exploration\' DLC";
			}

			if (!::Const.DLC.Wildmen)
			{
				disabledMotdText = disabledMotdText + "\nMissing \'Warriors of the North\' DLC\'";
			}

			if (!::Const.DLC.Desert)
			{
				disabledMotdText = disabledMotdText + "\nMissing \'Blazing Deserts\' DLC\'";
			}

			if (missingFiles.len() > 0)
			{
				foreach( fileType, fileName in missingFiles )
				{
					disabledMotdText = disabledMotdText + this.format("\nMissing %s file %s", fileType, fileName);
				}
			}

			this.m.JSHandle.asyncCall("setLMOTD", disabledMotdText);
		}
		else
		{
			this.m.JSHandle.asyncCall("setMOTD", "Welcome to Legends Beta. \n\n To report bugs, share strategies and ideas, or try out new test builds, join us on https://discord.gg/ZfCHGuC");
		}
	}

	function checkForRequiredFiles()
	{
		local missing = {};
		return missing;
	}

	function destroy()
	{
		this.clearEventListener();
		this.m.MainMenuModule.destroy();
		this.m.MainMenuModule = null;
		this.m.LoadCampaignModule.destroy();
		this.m.LoadCampaignModule = null;
		this.m.NewCampaignModule.destroy();
		this.m.NewCampaignModule = null;
		this.m.ScenarioMenuModule.destroy();
		this.m.ScenarioMenuModule = null;
		this.m.OptionsMenuModule.destroy();
		this.m.OptionsMenuModule = null;
		this.m.CreditsModule.destroy();
		this.m.CreditsModule = null;
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function show( _animate )
	{
		if (this.m.JSHandle != null && !this.isVisible())
		{
			this.Tooltip.hide();

			if (!::Const.DLC.Unhold && !::Const.DLC.Wildmen && !::Const.DLC.Wildmen)
			{
				this.m.JSHandle.asyncCall("noshow", null);
			}
			else
			{
				this.m.JSHandle.asyncCall("show", _animate);
			}
		}
	}

	function hide()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hide", null);
		}
	}

	function showLoadCampaignMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showLoadCampaignMenu", this.UIDataHelper.convertCampaignStoragesToUIData());
		}
	}

	function hideLoadCampaignMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideLoadCampaignMenu", null);
		}
	}

	function showNewCampaignMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showNewCampaignMenu", null);
		}
	}

	function hideNewCampaignMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideNewCampaignMenu", null);
		}
	}

	function showScenarioMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showScenarioMenu", this.m.ScenarioMenuModule.onQueryData());
		}
	}

	function hideScenarioMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideScenarioMenu", null);
		}
	}

	function showOptionsMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showOptionsMenu", this.m.OptionsMenuModule.onQueryData());
		}
	}

	function hideOptionsMenu()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideOptionsMenu", null);
		}
	}

	function showCredits()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showCredits", ::Const.Credits);
		}
	}

	function hideCredits()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideCredits", null);
		}
	}

	function setScenarioDemoModus()
	{
		if (this.m.JSHandle != null)
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("setScenarioDemoModus", null);
		}
	}

	function onScreenConnected()
	{
		if (this.m.OnConnectedListener != null)
		{
			this.m.OnConnectedListener();
		}
	}

	function onScreenDisconnected()
	{
		if (this.m.OnDisconnectedListener != null)
		{
			this.m.OnDisconnectedListener();
		}
	}

	function onScreenShown()
	{
		this.m.Visible = true;

		if (this.m.OnScreenShownListener != null)
		{
			this.m.OnScreenShownListener();
		}
	}

	function onScreenHidden()
	{
		this.m.Visible = false;

		if (this.m.OnScreenHiddenListener != null)
		{
			this.m.OnScreenHiddenListener();
		}
	}

};

