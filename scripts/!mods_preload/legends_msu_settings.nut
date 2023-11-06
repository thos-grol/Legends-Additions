::Const.LegendMod.addSettings <- function ()
{
	local addNCSetting = function ( _page, _setting )
	{
		_setting.getData().NewCampaign <- true;
		_setting.getData().NewCampaignOnly <- true;
		_page.addElement(_setting);
	};
	local map = ::Legends.Mod.ModSettings.addPage("Map Options");
	addNCSetting(map, ::MSU.Class.RangeSetting("LandRatio", 50, 45, 70, 1, "Land Mass Ratio", "Minimum land to water ratio for an acceptable map. Default is 50. Going either extremes on this slider can result in map never getting generated."));
	addNCSetting(map, ::MSU.Class.RangeSetting("Water", 38, 28, 48, 1, "Water", "Impacts how much of the map is water. Small value results in patchy water around the corners of the map. Larger numbers can create a single large island given a low enough land mass ratio."));
	addNCSetting(map, ::MSU.Class.RangeSetting("Snowline", 85, 75, 95, 1, "Snowline", "Determines where the snowline is generated. Default is 90. This value is inverted. A value of 10 would mean the top 90% of the map is snow."));
	addNCSetting(map, ::MSU.Class.RangeSetting("Settlements", 19, 19, 27, 1, "Settlements", "Maximum number of settlements. Depending on map size, this will try to add the number of settlements on the slider. It will keep the same ratio of settlement types as default Battle Brothers maps. Minimum distance between settlements is 12 tiles. Vanilla default is 19."));
	addNCSetting(map, ::MSU.Class.RangeSetting("Factions", 3, 1, 6, 1, "Factions", "Maximum number of Factions to try and generate. Depending on map size, this may not add all the factions on the slider."));
	addNCSetting(map, ::MSU.Class.SettingsDivider("MapDivider1"));
	addNCSetting(map, ::MSU.Class.BooleanSetting("StackCitadels", true, "Decked Out Citadels", "If enabled, every Citadel will start with all those building attachments map scummers are re-rolling for."));
	addNCSetting(map, ::MSU.Class.BooleanSetting("AllTradeLocations", true, "All trade buildings available", "If enabled, ensures there is at least one of each trade location building on the map."));
	addNCSetting(map, ::MSU.Class.BooleanSetting("DebugMap", false, "(Debug) Show Entire Map", "If enabled, the map will start completely revealed and all enemies and camps will be visible."));
	::Legends.Mod.ModSettings.getSetting("StackCitadels").lock("Locked.");
	::Legends.Mod.ModSettings.getSetting("AllTradeLocations").lock("Locked.");

	local config = ::Legends.Mod.ModSettings.addPage("Campaign Options");
	addNCSetting(config, ::MSU.Class.EnumSetting("GenderEquality", "Enabled", [
		"Disabled",
		"Enabled",
		"Enabled (Cosmetic)"
	], "Battle Sisters", "When enabled, most backgrounds will be randomly assigned male or female. Some backgrounds will remain exclusively male or female.\n\n[u]Disabled[/u]\nThe vanilla experience. No backgrounds or enemy encounters with females. (Yes, your friend the Hex is still here!)\n\n[u]Enabled[/u]\nBeing female has gameplay effects.\n\n[u]Enabled (Cosmetic)[/u]\nBeing female has no gameplay effects."));
	addNCSetting(config, ::MSU.Class.SettingsDivider("ConfigDivider1"));
	addNCSetting(config, ::MSU.Class.BooleanSetting("DistanceScaling", true, "Distance Scaling", "If enabled, enemies will be stronger the further they spawn from civilization. \n\n Detail: Begins at 14 tiles from the nearest town, enemies spawned at 28 tiles will be twice as strong. \n\n This is in addition to other difficulty settings."));
	addNCSetting(config, ::MSU.Class.BooleanSetting("SkipCamp", true, "Skip Camp Tutorial", "If disabled, you will gradually unlock camping activities by visiting towns. Useful for first playthroughs. \n\n Detail: skips the camp unlock events and ambition, you still need to buy upgrades."));
	addNCSetting(config, ::MSU.Class.BooleanSetting("RecruitScaling", true, "Recruit Scaling", "If enabled, new recruits will gain levels based on the levels in your party and your renown in the world. \n\n  Details: The maximum level of recruits is increased by half the average level of mercs in your company, averaged with your reputation divided by 1,000. \n\n For example: if your company were all level 10, and your renown was 10,000, new recruits could gain up to 7 levels rounded down. \n\n This in addition to normal recruit level variance."));
	addNCSetting(config, ::MSU.Class.BooleanSetting("BleedKiller", true, "Bleeds Count As Kills", "If enabled, kills by bleeding out are granted to the actor who caused the bleed."));
	addNCSetting(config, ::MSU.Class.BooleanSetting("WorldEconomy", true, "World Economy", "If enabled, Settlements will actively trade items and resources and can grow or decline in value \n\n  Details: The value of a settlement is now a dynamic value that grows and declines with caravan arrivals and departures, contracts fullfilled or failed, good or bad settlement events. \n\n The value of the settlement determines how valuable the caravans it creates are, as well as the strength of local militia. \n\n Very prosperous settlements will continue to grow and potentialy add new locations."));
	addNCSetting(config, ::MSU.Class.SettingsDivider("ConfigDivider2"));
	local tooltip = ::Legends.Mod.ModSettings.addPage("Tooltips / UI");
	tooltip.addTitle("TooltipCombat", "Tooltips - Combat");

	tooltip.addElement(::MSU.Class.BooleanSetting("EnhancedTooltips", true, "Enhanced Enemy Tooltips", "Enemy tooltips in tactical battles will show more information, like perks and statuses"));
	::Legends.Mod.ModSettings.getSetting("EnhancedTooltips").lock("Locked.");
	
	tooltip.addDivider("TooltipDivider1");
	tooltip.addTitle("TooltipInventory", "Tooltips - Inventory");
	tooltip.addElement(::MSU.Class.BooleanSetting("ShowArmorPerFatigueValue", true, "Show Armor/Fatigue Efficiency", "Show the Armor value gained per unit of Fatigue cost of an Armor/Helmet Piece/Layer in the Tooltip when the player mouses over an individual Armor/Helmet Piece/Layer.\n\nUseful for people who like to buy their groceries based on price per unit weight"));
	tooltip.addElement(::MSU.Class.BooleanSetting("ShowExpandedArmorLayerTooltip", true, "Expanded Armor Layer Tooltips", "Show the Armor value and Fatigue cost of each Armor/Helmet layer in the Tooltip when the player mouses over a combined Armor/Helmet set.\n\nDisabling this may help reduce the Tooltip length to fit better on lower resolution screens"));
	tooltip.addDivider("TooltipDivider2");
	tooltip.addTitle("TooltipCharacter", "Tooltips - Character");
	tooltip.addElement(::MSU.Class.BooleanSetting("ShowCharacterBackgroundType", true, "Show Character Background Types", "Show a character\'s Background Types in Tooltips.\n\nUseful when playing Origins with additional gameplay mechanics based on Background Types"));
	tooltip.addDivider("TooltipDivider3");
	tooltip.addTitle("TooltipUI", "UI");
	local cpLight = tooltip.addElement(::MSU.Class.ColorPickerSetting("HighlightLightBackground", "2,55,189,1", "Highlighted Text (Light Background)", "Customize the color for special highlighted text occurring in light backgrounds, such as in tooltips"));
	::Const.UI.Color.getHighlightLightBackgroundValue <- function ()
	{
		return "#" + cpLight.getValueAsHexString().slice(0, 6);
	};
	local cpDark = tooltip.addElement(::MSU.Class.ColorPickerSetting("HighlightDarkBackground", "111,145,201,1", "Highlighted Text (Dark Background)", "Customize the color of special highlighted text occurring in dark backgrounds, such as in events"));
	::Const.UI.Color.getHighlightDarkBackgroundValue <- function ()
	{
		return "#" + cpDark.getValueAsHexString().slice(0, 6);
	};
	tooltip.addElement(::MSU.Class.EnumSetting("ContractCategoryIconAlignment", "Middle", [
		"Left",
		"Middle",
		"Right",
		"Below"
	], "Contract Category Icon Alignment", "Adjust the position of the Contract Category icon at the bottom of Contracts in the Settlement screen"));
	local misc = ::Legends.Mod.ModSettings.addPage("Misc");
	local myEnumTooltip = "Define how Blueprints are shown: \'All Ingredients Available\' is the Vanilla behavior; \'One Ingredient Available\' shows recipes when one ingredient is fully satisfied; \'Always\' shows all recipes at all time";
	
	misc.addElement(::MSU.Class.EnumSetting("ShowBlueprintsWhen", "One Ingredient Available", [
		"All Ingredients Available",
		"One Ingredient Available",
		"Always"
	], "Show Blueprints when", myEnumTooltip));
	::Legends.Mod.ModSettings.getSetting("ShowBlueprintsWhen").lock("Locked.");

	misc.addElement(::MSU.Class.BooleanSetting("AutoRepairLayer", false, "Autorepair Layer", "Any Body or Helmet Layer that you strip from a piece of armor is automatically marked as \'to be repaired\'."));
	misc.addElement(::MSU.Class.BooleanSetting("ClickPresetToSwitch", false, "Faster Camping Preset Switch", "Clicking on the camping preset slot immediately applies the preset"));
	local logging = ::Legends.Mod.ModSettings.addPage("Logging");

	foreach( f in ::Const.LegendMod.Debug.FlagDefs )
	{
		local b = logging.addElement(::MSU.Class.BooleanSetting(f.ID, f.Value, f.Name, f.Description));
		b.Data.FlagID <- f.ID;
		b.addCallback(function ( _value )
		{
			::Legends.Mod.Debug.setFlag(this.Data.FlagID, _value);
		});
	}
};