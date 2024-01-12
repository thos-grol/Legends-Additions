this.bandit_raider <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Raider";
		this.m.Type = ::Const.EntityType.BanditRaider;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditRaider.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditRaider);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
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
				"bandit_armor_medium"
			],
			[
				2,
				"bandit_armor_light"
			],
			[
				2,
				"leather_lamellar"
			]
		];
		local helmet = [
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"rondel_helm"
			],
			[
				1,
				"barbute_helmet"
			],
			[
				1,
				"scale_helm"
			],
			[
				1,
				"dented_nasal_helmet"
			],
			[
				1,
				"rusty_mail_coif"
			],
			[
				1,
				"headscarf"
			],
			[
				1,
				"nasal_helmet_with_rusty_mail"
			]
		];
		local outfits = [
			[
				1,
				"dark_southern_outfit_00"
			]
		];

		foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item);
		}
	}

});

