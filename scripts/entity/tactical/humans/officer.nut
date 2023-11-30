this.officer <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Officer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Officer.XP;
		this.abstract_human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Officer);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
	}

	function pickOutfit()
	{
		local r;
		local banner = 3;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"oriental/padded_mail_and_lamellar_hauberk"
				],
				[
					1,
					"oriental/southern_long_mail_with_padding"
				],
				[
					1,
					"oriental/mail_and_lamellar_plating"
				]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[
					1,
					"oriental/turban_helmet"
				],
				[
					1,
					"oriental/heavy_lamellar_helmet"
				],
				[
					1,
					"oriental/southern_helmet_with_coif"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = this.Math.rand(1, 4);
		if (r == 1) //helmet
		{
			local named = this.Const.Items.NamedSouthernHelmets;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}
		else if (r == 2) //armor
		{
			local named = this.Const.Items.NamedSouthernArmors;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

