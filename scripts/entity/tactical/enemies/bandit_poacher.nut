this.bandit_poacher <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Thug";
		this.m.Type = this.Const.EntityType.BanditPoacher;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);

		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		this.abstract_human.assignRandomEquipment();
		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
	}

});

