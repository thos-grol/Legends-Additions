//unbreaking
//curse 8
//bound by life
//drawn by hatred
//fated death - ignores luck rerolling, grants fast adaptation
//

this.rueful_axe <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		UUID = 0,
		Rolled_UUID = false,
		CursePoints = 8
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rueful_axe";
		this.m.Name = "Rueful Axe";
		this.m.Description = "A cursed weapon with a cursed story...";
		this.m.IconLarge = "weapons/melee/axe_01.png"; //TODO: make red axe aura inventory
		this.m.Icon = "weapons/melee/axe_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_axe_01";
		this.m.Value = 210;
		this.m.ShieldDamage = 16;
		this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 44;
		this.m.RegularDamageMax = 66;
		this.m.ArmorDamageMult = 1.44;
		this.m.DirectDamageMult = 0.44;

		rollUUID();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/chop"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		this.addSkill(skillToAdd);

		if (actor.getSkills().getSkillByID("effect.cursed") == null)
			actor.getSkills().add(::new("scripts/skills/effects/cursed_effect"));

		if (actor.getSkills().getSkillByID("perk.fast_adaption") == null)
			actor.getSkills().add(::new("scripts/skills/perks/perk_fast_adaption"));

		actor.getFlags().set("IgnoreLuck", true);

		local has_lifebound = false;

		local actor = this.getContainer().getActor();
		foreach (skill in actor.getSkills().getSkillsByFunction((@(_skill) "UUID" in _skill.m ).bindenv(this)))
		{
			if (skill.m.UUID != this.m.UUID) continue;
			has_lifebound = true;
			break;
		}

		if (!has_lifebound)
		{
			local lifebound = ::new("scripts/skills/traits/lifebound_trait");
			lifebound.setUUID(this.m.UUID);
			this.addSkill(lifebound);
		}
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.TargetAttractionMult *= 10.0;
	}

	function rollUUID()
	{
		if (this.m.Rolled_UUID) return;
		this.m.UUID = ::Math.rand(0, 65534);
	}

	function onSerialize( _out )
	{
		this.weapon.onSerialize(_out);
		_out.writeU16(this.m.UUID);
		_out.writeBool(this.m.Rolled_UUID);
	}

	function onDeserialize( _in )
	{
		this.weapon.onDeserialize(_in);
		this.m.UUID = _in.readU16();
		this.m.Rolled_UUID = _in.readBool();
	}

});

