local gt = this.getroottable();

this.legend_staff_ceremonial <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_staff_vala";
		this.m.NameList = ::Const.Strings.StaffNames;
		this.m.Description = "A beautiful staff with the distinctive twisted design of a vala.";
		this.m.IconLarge = "weapons/melee/legend_staff_05_named.png";
		this.m.Icon = "weapons/melee/legend_staff_05_named_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Staff | ::Const.Items.WeaponType.MagicStaff;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_staff_05";
		this.m.Value = 2000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.4;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local s = ::new("scripts/skills/actives/legend_staff_bash");
		s.m.Icon = "skills/staff_bash_vala.png";
		s.m.IconDisabled = "skills/staff_bash_vala_bw.png";
		this.addSkill(s);
		local t = ::new("scripts/skills/actives/legend_staff_knock_out");
		t.m.Icon = "skills/staff_knock_out_vala.png";
		t.m.IconDisabled = "skills/staff_knock_out_vala_bw.png";
		this.addSkill(t);
	}

	function randomizeValues()
	{
		if (this.m.ConditionMax > 1)
		{
			this.m.Condition = this.Math.round(this.m.Condition * this.Math.rand(90, 140) * 0.01) * 1.0;
			this.m.ConditionMax = this.m.Condition;
		}

		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});

		if (this.m.ChanceToHitHead > 0)
		{
			available.push(function ( _i )
			{
				_i.m.ChanceToHitHead = _i.m.ChanceToHitHead + this.Math.rand(10, 20);
			});
		}

		if (this.m.StaminaModifier <= -10)
		{
			available.push(function ( _i )
			{
				_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(50, 80) * 0.01);
			});
		}

		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
			n = --n;
		}
	}
});

