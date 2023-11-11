::Legends <- {
	ID = "mod_legends",
	Version = "18.1.1",
	Name = "Legends Mod",
	BuildName = "Camps & Contracts"
};
::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);
::mods_queue(null, "mod_msu(>=1.2.6), vanilla(>=1.5.0-15), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins", function ()
{
	::Legends.Mod <- ::MSU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);
	::mods_registerJS("legends_assets.js");
	::LegendsMod <- ::new("scripts/mods/legends_mod");
	::Legends.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Brothers-Legends/Legends-Bugs");
	::Legends.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	::Const.LegendMod.setupDebug();
	::Const.LegendMod.addSettings();
	::Const.LegendMod.hookMSU();
	::Const.LegendMod.addLegendItemTypes();
	::Const.LegendMod.addStaticFunctions();
	::Const.LegendMod.hookActor();
	::Const.LegendMod.hookAISkills();
	::Const.LegendMod.hookAIAgent();
	::Const.LegendMod.hookAISplitShield();
	::Const.LegendMod.hookAlpRacial();
	::Const.LegendMod.hookBehavior();
	::Const.LegendMod.hookCharacterBackground();
	::Const.LegendMod.hookCombatManager();
	::Const.LegendMod.hookContract();
	::Const.LegendMod.hookContractCategory();
	::Const.LegendMod.hookFactionAction();
	::Const.LegendMod.hookGhoul();
	::Const.LegendMod.hookItemContainer();
	::Const.LegendMod.hookStrategy();
	::Const.LegendMod.hookTacticalEntityManager();
	::Const.LegendMod.hookTacticalState();
	::Const.LegendMod.hookWorldmapGenerator();
	::Const.LegendMod.registerUI();
	::Const.LegendMod.loadBuyback();
	::Const.LegendMod.loadTacticalTooltip();
	// ::Const.Perks.updatePerkGroupTooltips();
	::Const.LegendMod.addTooltips();
});

