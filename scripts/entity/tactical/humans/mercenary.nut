this.mercenary <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Mercenary;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Mercenary.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Mercenary);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function pickOutfit()
	{
		local armor = [
			[
				1,
				"sellsword_armor"
			],
			[
				1,
				"reinforced_mail_hauberk"
			],
			[
				1,
				"mail_hauberk"
			],
			[
				1,
				"traze_northern_mercenary_armor"
			],
			[
				1,
				"northern_mercenary_armor_00"
			],
			[
				1,
				"northern_mercenary_armor_01"
			],
			[
				1,
				"northern_mercenary_armor_02"
			],
			[
				1,
				"lamellar_harness"
			],
			[
				1,
				"footman_armor"
			],
			[
				1,
				"light_scale_armor"
			],
			[
				1,
				"leather_scale_armor"
			]
		];
		local helm = [
			[
				1,
				""
			],
			[
				5,
				"nasal_helmet_with_mail"
			],
			[
				5,
				"nasal_helmet"
			],
			[
				5,
				"mail_coif"
			],
			[
				5,
				"reinforced_mail_coif"
			],
			[
				5,
				"headscarf"
			],
			[
				5,
				"kettle_hat"
			],
			[
				5,
				"kettle_hat_with_mail"
			],
			[
				5,
				"rondel_helm"
			],
			[
				5,
				"traze_northern_mercenary_cap"
			],
			[
				5,
				"deep_sallet"
			],
			[
				5,
				"scale_helm"
			],
			[
				5,
				"flat_top_helmet"
			],
			[
				5,
				"flat_top_with_mail"
			],
			[
				5,
				"closed_flat_top_helmet"
			],
			[
				5,
				"closed_mail_coif"
			],
			[
				5,
				"bascinet_with_mail"
			],
			[
				5,
				"nordic_helmet"
			],
			[
				5,
				"nordic_helmet_with_closed_mail"
			],
			[
				5,
				"legend_enclave_vanilla_kettle_sallet_02"
			],
			[
				5,
				"legend_enclave_vanilla_kettle_sallet_03"
			],
			[
				5,
				"legend_enclave_vanilla_skullcap_01"
			],
			[
				5,
				"steppe_helmet_with_mail"
			],
			[
				5,
				"barbute_helmet"
			]
		];
		helm.push([
			5,
			"theamson_barbute_helmet"
		]);
		local outfits = [
			[
				1,
				"northern_mercenary_outfit_00"
			],
			[
				1,
				"northern_mercenary_outfit_01"
			],
			[
				1,
				"northern_mercenary_outfit_02"
			],
			[
				1,
				"traze_northern_mercenary_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helm) )
		{
			this.m.Items.equip(item);
		}
	}

});

