this.legend_bandit_warlord <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditWarlord;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditWarlord.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(this.Const.Strings.BanditLeaderNames[this.Math.rand(0, this.Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditWarlord);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.6);
		this.getSprite("shield_icon").setBrightness(0.6);
	}

	// shields.extend([
	// 	"shields/named/named_bandit_kite_shield",
	// 	"shields/named/named_bandit_heater_shield"
	// ]);

	// "weapons/noble_sword",
	// "weapons/fighting_axe",
	// "weapons/warhammer",
	// "weapons/boar_spear",
	// "weapons/legend_glaive",
	// "weapons/winged_mace",
	// "weapons/arming_sword",
	// "weapons/military_cleaver"
	// "weapons/greatsword",
	// "weapons/greataxe",
	// "weapons/legend_swordstaff",
	// "weapons/legend_longsword",
	// "weapons/warbrand",
	// "weapons/legend_estoc"

	// "shields/wooden_shield",
	// "shields/heater_shield",
	// "shields/kite_shield"

	function pickOutfit()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local armor = [
				[
					1,
					"bandit_armor_ultraheavy"
				],
				[
					2,
					"coat_of_plates"
				],
				[
					2,
					"coat_of_scales"
				],
				[
					2,
					"heavy_lamellar_armor"
				],
				[
					1,
					"reinforced_mail_hauberk"
				],
				[
					1,
					"brown_hedgeknight_armor"
				],
				[
					1,
					"northern_mercenary_armor_02"
				]
			];
			local item = this.Const.World.Common.pickArmor(armor);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local helmet = [
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat_with_closed_mail"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"bascinet_with_mail"
				]
			];
			local item = this.Const.World.Common.pickHelmet(helmet);
			this.m.Items.equip(item);
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

