::mods_hookExactClass("entity/world/settlements/city_state.nut", function(o) {
	o.create = function()
	{
		this.settlement.create();
		this.m.Name = this.getRandomName([
			"ORIENTAL CITY #1",
			"ORIENTAL CITY #2",
			"ORIENTAL CITY #3"
		]);
		this.m.FemaleDraftList = [
			"female_thief_southern_background",
			"female_slave_background",
			"female_slave_southern_background",
			"female_slave_southern_background",
			"female_slave_southern_background",
			"female_slave_southern_background",
			"legend_qiyan_background"
		];
		this.m.DraftList = [
			"beggar_southern_background",
			"beggar_southern_background",
			"butcher_southern_background",
			"caravan_hand_southern_background",
			"caravan_hand_southern_background",
			"caravan_hand_southern_background",
			"gambler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",
			"historian_southern_background",
			"peddler_southern_background",
			"peddler_southern_background",
			"servant_southern_background",
			"shepherd_southern_background",
			"shepherd_southern_background",
			"tailor_southern_background",
			"thief_southern_background",
			"disowned_noble_background",
			"sellsword_background",
			"cripple_southern_background",
			"eunuch_southern_background",
			"slave_background",
			"slave_background",
			"female_slave_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"slave_southern_background",
			"manhunter_background",
			"manhunter_background",
			"nomad_background",
			"nomad_background",
			"nomad_ranged_background",
			"juggler_southern_background",
			"assassin_southern_background",
			"legend_muladi_background",
			"legend_dervish_background"
		];

		if (this.Const.DLC.Unhold)
		{
			this.m.DraftList.push("beast_hunter_background");
		}

		this.m.UIDescription = "A large and rich city state that thrives on trade at the edge of the desert";
		this.m.Description = "A large and rich city state that thrives on trade at the edge of the desert.";
		this.m.UIBackgroundCenter = "ui/settlements/desert_stronghold_03";
		this.m.UIBackgroundLeft = "ui/settlements/desert_bg_houses_03_left";
		this.m.UIBackgroundRight = "ui/settlements/desert_bg_houses_03_right";
		this.m.UIRampPathway = "ui/settlements/desert_ramp_01_cobblestone";
		this.m.UISprite = "ui/settlement_sprites/citystate_01.png";
		this.m.Sprite = "world_city_01";
		this.m.Lighting = "world_city_01_light";
		this.m.Rumors = this.Const.Strings.RumorsDesertSettlement;
		this.m.Culture = this.Const.World.Culture.Southern;
		this.m.IsMilitary = false;
		this.m.Size = 3;
		this.m.HousesType = 4;
		this.m.HousesMin = 4;
		this.m.HousesMax = 6;
		this.m.AttachedLocationsMax = 6;
	}

});
