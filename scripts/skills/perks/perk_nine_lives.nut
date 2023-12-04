::Const.Strings.PerkName.NineLives <- "Nine Lives";
::Const.Strings.PerkDescription.NineLives <- "Like a cat..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Upon taking fatal damage:")
+ "\n"+::MSU.Text.colorGreen("+Death immunity") + " till turn start"
+ "\n"+::MSU.Text.colorGreen("+Remove DOT effects")
+ "\n"+::MSU.Text.colorRed("Effect occurs once per battle");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.NineLives].Name = ::Const.Strings.PerkName.NineLives;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.NineLives].Tooltip = ::Const.Strings.PerkDescription.NineLives;

//gt.Const.Perks.PerkDefs.LegendSecondWind

this.perk_nine_lives <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		Immunity = false,
		LastFrameUsed = 0,
		MinHP = 11,
		MaxHP = 15,
		RemoveDamageOverTime = true,
		DamageOverTimeSkills = []
	},
	function isSpent()
	{
		return this.m.IsSpent;
	}

	function getLastFrameUsed()
	{
		return this.m.LastFrameUsed;
	}

	function create()
	{
		this.m.ID = "perk.nine_lives";
		this.m.Name = ::Const.Strings.PerkName.NineLives;
		this.m.Description = ::Const.Strings.PerkDescription.NineLives;
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.IconMini = "perk_07_mini";
		this.m.Overlay = "perk_07";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.VeryLast + 10000;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function setSpent( _f )
	{
		if (_f && !this.m.IsSpent)
		{
			this.m.IsHidden = false;

			if (this.m.MinHP != 11 || this.m.MaxHP != 15)
			{
				this.getContainer().getActor().m.Hitpoints = ::Math.rand(this.m.MinHP, this.m.MaxHP);
				this.getContainer().getActor().setDirty(true);
			}

			foreach( skill in this.m.DamageOverTimeSkills )
			{
				skill.m.SkillType += ::Const.SkillType.DamageOverTime;
			}

			this.m.DamageOverTimeSkills.clear();
			this.m.Immunity = true;
			this.onProc();
		}

		this.m.IsSpent = _f;
		this.m.LastFrameUsed = this.Time.getFrame();
	}

	function onProc()
	{
	}

	function onTurnStart()
	{
		this.m.Immunity = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.Immunity) _properties.DamageReceivedRegularMult *= 0;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.m.RemoveDamageOverTime && _damageHitpoints > this.getContainer().getActor().getHitpoints())
		{
			this.m.DamageOverTimeSkills = this.getContainer().getSkillsByFunction(function ( skill )
			{
				return skill.isType(::Const.SkillType.DamageOverTime);
			});

			foreach( skill in this.m.DamageOverTimeSkills )
			{
				skill.m.SkillType -= ::Const.SkillType.DamageOverTime;
			}
		}
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
		this.skill.onCombatFinished();
	}

	function onUpdate( _properties )
	{
		if (this.m.RemoveDamageOverTime && this.m.IsSpent && this.m.LastFrameUsed == this.Time.getFrame())
		{
			this.getContainer().removeByType(::Const.SkillType.DamageOverTime);
		}
	}

});

