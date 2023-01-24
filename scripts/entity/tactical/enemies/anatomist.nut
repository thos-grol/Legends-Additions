this.anatomist <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Mercenary;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Mercenary.XP;
		this.m.Name = "Anatomist";
		this.human.create();
		this.m.Faces = ::Const.Faces.SmartMale;
		this.m.Hairs = ::Const.Hair.TidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Mercenary);
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_miniboss_lone_wolf");
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_versatile_weapon"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_kata"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_en_garde"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		{
			this.getSkills().add(::new("scripts/skills/perks/perk_ptr_exploit_opening"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_fluid_weapon"));
		}

		local roll = this.Math.rand(1.0, 100.0);
		if (roll <= 16.0) this.add_potion("serpent", true);
		else if (roll <= 32.0) this.add_potion("spider", false);
		else if (roll <= 48.0) this.add_potion("direwolf", false);
		else if (roll <= 64.0) this.add_potion("ghoul", false);
		else if (roll <= 80.0) this.add_potion("orc", false);

		roll = this.Math.rand(1.0, 100.0);
		local c = 5.0 * this.getScaledDifficultyMult();

		if (roll <= c) this.makeMiniboss();
	}

	function getScaledDifficultyMult()
	{
		local s = this.Math.maxf(0.5, 0.6 * this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.9));
		local d = this.Math.minf(0, s + this.Math.minf(1.0, this.World.getTime().Days * 0.01));
		return d * ::Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{	
		
		// if (this.Math.rand(1.0, 100.0) <= 5.0)
		// {
		// 	//FEATURE_1: Anatomist research notes + add to possible books
		// }
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/arming_sword"
			];

			if (::Const.DLC.Wildmen || ::Const.DLC.Desert)
			{
				weapons.extend([
					"weapons/shamshir"
				]);
			}

			this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			if (this.Math.rand(1, 100) <= 50) this.m.Items.equip(::new("scripts/items/armor/undertaker_apron"));
			else this.m.Items.equip(::new("scripts/items/armor/wanderers_coat"));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 90)
		{
			if (this.Math.rand(1, 100) <= 50)  this.m.Items.equip(::new("scripts/items/helmets/undertaker_hat"));
			else this.m.Items.equip(::new("scripts/items/helmets/physician_mask"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.m.Name = this.generateName();
		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_sword"
		];

		if (::Const.DLC.Wildmen || ::Const.DLC.Desert)
		{
			weapons.extend([
				"weapons/named/named_sword",
				"weapons/named/named_shamshir"
			]);
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		this.m.BaseProperties.DamageDirectMult *= 1.25;
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		return true;
	}

});