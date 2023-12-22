::mods_hookExactClass("states/main_menu_state", function (o)
{
    o.postInit <- function()
	{
		// show();
		
		//Add perk group descriptions
		local PERKS = {};
        local GROUPS = [::Const.Perks.TraitsTrees, ::Const.Perks.DefenseTrees, ::Const.Perks.WeaponTrees, ::Const.Perks.ClassTrees];
		foreach(group in GROUPS)
		{
			foreach(tree in group.Tree)
			{
				foreach(row in tree.Tree)
				{
					foreach(perk in row)
					{
						if (::Const.Perks.PerkDefObjects[perk].Name in PERKS)
							::Const.Perks.PerkDefObjects[perk].Tooltip += ::MSU.Text.color(::Z.Color.Blue, ", " + tree.Name);
						else
						{
							::Const.Perks.PerkDefObjects[perk].Tooltip += ::MSU.Text.color(::Z.Color.Blue, "\n\n" + tree.Name);
							PERKS[::Const.Perks.PerkDefObjects[perk].Name] <- null;
						}
					}
				}
			}
		}
	}

    local onInit = o.onInit;
    o.onInit = function()
	{
        this.m.ScenarioManager <- this.new("scripts/scenarios/scenario_manager");
		::Const.ScenarioManager <- this.m.ScenarioManager;
		this.m.MenuStack <- this.new("scripts/ui/global/menu_stack");
		this.m.MenuStack.setEnviroment(this);
		this.m.MainMenuScreen <- this.new("scripts/ui/screens/menu/main_menu_screen");
		this.m.MainMenuScreen.setOnScreenShownListener(this.main_menu_screen_onScreenShown.bindenv(this));
		this.m.MainMenuScreen.setOnConnectedListener(this.main_menu_screen_onConnected.bindenv(this));
		local mainMenuModule = this.m.MainMenuScreen.getMainMenuModule();

		if (!this.isScenarioDemo())
		{
			mainMenuModule.setOnNewCampaignPressedListener(this.main_menu_module_onNewCampaignPressed.bindenv(this));
			mainMenuModule.setOnLoadCampaignPressedListener(this.main_menu_module_onLoadCampaignPressed.bindenv(this));
		}

		mainMenuModule.setOnScenariosPressedListener(this.main_menu_module_onScenariosPressed.bindenv(this));
		mainMenuModule.setOnOptionsPressedListener(this.main_menu_module_onOptionsPressed.bindenv(this));
		mainMenuModule.setOnCreditsPressedListener(this.main_menu_module_onCreditsPressed.bindenv(this));
		mainMenuModule.setOnQuitPressedListener(this.main_menu_module_onQuitPressed.bindenv(this));
		local loadCampaignMenuModule = this.m.MainMenuScreen.getLoadCampaignMenuModule();
		loadCampaignMenuModule.setOnLoadButtonPressedListener(this.campaign_menu_module_onLoadPressed.bindenv(this));
		loadCampaignMenuModule.setOnCancelButtonPressedListener(this.campaign_menu_module_onCancelPressed.bindenv(this));
		local newCampaignMenuModule = this.m.MainMenuScreen.getNewCampaignMenuModule();
		newCampaignMenuModule.setOnStartButtonPressedListener(this.campaign_menu_module_onStartPressed.bindenv(this));
		newCampaignMenuModule.setOnCancelButtonPressedListener(this.campaign_menu_module_onCancelPressed.bindenv(this));
		local scenarioMenuModule = this.m.MainMenuScreen.getScenarioMenuModule();
		scenarioMenuModule.setOnPlayButtonPressedListener(this.scenario_menu_module_onPlayPressed.bindenv(this));
		scenarioMenuModule.setOnCancelButtonPressedListener(this.scenario_menu_module_onCancelPressed.bindenv(this));
		scenarioMenuModule.setOnQueryDataListener(this.scenario_menu_module_onQueryData.bindenv(this));
		local optionsMenuModule = this.m.MainMenuScreen.getOptionsMenuModule();
		optionsMenuModule.setOnOkButtonPressedListener(this.options_menu_module_onOkPressed.bindenv(this));
		optionsMenuModule.setOnCancelButtonPressedListener(this.options_menu_module_onCancelPressed.bindenv(this));
		local creditsModule = this.m.MainMenuScreen.getCreditsModule();
		creditsModule.setOnDoneListener(this.credits_module_onDone.bindenv(this));
		this.m.MainMenuScreen.connect();
		this.initLoadingScreenHandler();
		this.show(); //show upon button sounds loading
        postInit();
	}

});
