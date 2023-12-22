this.spell_flesh_servant_bind <- this.inherit("scripts/skills/_magic_active", {
	m = {
		Used = false,
		Name_ = null,
		Type_ = null,
		Skills = [],
		BaseProperties = {},
		Absorbed = 0
	},
	function create()
	{
		this.m.ID = "actives.spell.flesh_servant_bind";
		this.m.Name = "Bind Flesh Servant";
		this.m.Description = "Bind a corpse to be your most loyal servant and keep them by your side...";
		this.m.Icon = "skills/raisedead2.png"; //FEATURE_0: ART HOME flesh_servant_bind
		this.m.IconDisabled = "skills/raisedead2_bw.png";
		this.m.Overlay = "active_26";
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;

		this.m.Aspect = "winter";
		this.m.ManaCost = 2;
		this.m.Cooldown_Max = 1;
		this.m.Cooldown = 1;

		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;

		this.m.IsSerialized = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() == ::Const.Faction.Player) return; //non-player generate summons
		if (::Math.rand(1, 100) <= 50)
		{
			this.m.Name_ = "Flesh Abomination (Goblin Ambusher)";
			this.m.Type_ = "scripts/entity/tactical/enemies/flesh_abomination_ranged";
			this.m.BaseProperties = {MeleeSkill = 60, Initiative = 140, MeleeDefense = 25, Bravery = 55, RangedSkill = 83, RangedDefense = 20};

			local temp = ["scripts/skills/perks/perk_death_dealer", "scripts/skills/perks/perk_dodge", "scripts/skills/perks/perk_legend_wind_reader", "scripts/skills/perks/perk_mastery_bow", "scripts/skills/perks/perk_underdog", "scripts/skills/actives/wake_ally_skill", "scripts/skills/racial/goblin_ambusher_racial"];
			foreach(script in temp)
			{
				this.m.Skills.push(::new(script));
			}
		}
		else
		{
			this.m.Name_ = "Flesh Abomination (Webknecht Armor)";
			this.m.Type_ = "scripts/entity/tactical/enemies/flesh_abomination";
			this.m.BaseProperties = {MeleeSkill = 65, Armor = [500, 500], Initiative = 100, MeleeDefense = 15, Bravery = 45, RangedSkill = 0, RangedDefense = 25};

			local temp = ["scripts/skills/perks/perk_backstabber", "scripts/skills/perks/perk_battle_forged", "scripts/skills/perks/perk_overwhelm", "scripts/skills/perks/perk_pathfinder", "scripts/skills/perks/perk_survival_instinct", "scripts/skills/perks/perk_underdog", "scripts/skills/actives/spider_bite_skill", "scripts/skills/actives/web_skill", "scripts/skills/actives/sprint_skill_5", "scripts/skills/actives/footwork", "scripts/skills/actives/legend_climb"];
			foreach(script in temp)
			{
				this.m.Skills.push(::new(script));
			}
		}


	}


	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile)
			&& canBind(_targetTile)
			&& _targetTile.IsEmpty;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this._magic_active.isUsable() && !this.m.Used;
	}

	function cast( _user, _targetTile )
	{
		this.m.Used = true;
		if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			::Z.Log.display_basic(_user, null, this.m.Name, _user.getFaction() == ::Const.Faction.Player || _user.getFaction() == ::Const.Faction.PlayerAnimals);

		for( local i = 1; i <= 5; i++ )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200 * i, this.spawn_particles.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _user.getTile()
			});
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1200, this.spawn_particles.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1700, this.spawn_particles.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 2000, this.bind_undead.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	//Helper

	function canResurrectOnTile( _tile, _force = false )
	{
		if (!_tile.IsCorpseSpawned) return false;
		if (_force) return true;
		if (_tile.Properties.get("Corpse").IsResurrectable || !("FleshNotAllowed" in _tile.Properties.get("Corpse")) ) return true;

		return false;
	}

	function bind_undead(tag)
	{
		local _info = tag.TargetTile.Properties.get("Corpse");

		if (_info.Name.len() != 0) this.m.Name_ = "Flesh Abomination (" + _info.Name + ")";
        else if (_info.CorpseName.len() != 0) this.m.Name_ = "Flesh Abomination (" + _info.CorpseName + ")";

		if (_info.BaseProperties["MeleeSkill"] >= _info.BaseProperties["RangedSkill"])
            this.m.Type_ = "scripts/entity/tactical/enemies/flesh_abomination";
        else this.m.Type_ = "scripts/entity/tactical/enemies/flesh_abomination_ranged";

		this.m.Skills.clear();
		if ("Skills" in _info)
        {
            foreach(skill in _info.Skills)
            {
                if (skill.m.ID in ::Z.Map) this.m.Skills.push(skill)
            }
        }

        if ("BaseProperties" in _info)
        {
            this.m.BaseProperties.Bravery <- _info.BaseProperties["Bravery"];
            this.m.BaseProperties.Initiative <- _info.BaseProperties["Initiative"];
            this.m.BaseProperties.MeleeSkill <- _info.BaseProperties["MeleeSkill"];
            this.m.BaseProperties.RangedSkill <- _info.BaseProperties["RangedSkill"];
            this.m.BaseProperties.MeleeDefense <- _info.BaseProperties["MeleeDefense"];
            this.m.BaseProperties.RangedDefense <- _info.BaseProperties["RangedDefense"];
            this.m.BaseProperties.Armor <- _info.BaseProperties["Armor"];
        }

		this.Tactical.Entities.removeCorpse(tag.TargetTile);
		tag.TargetTile.clear(::Const.Tactical.DetailFlag.Corpse);
		tag.TargetTile.Properties.remove("Corpse");
		tag.TargetTile.Properties.remove("IsSpawningFlies");
	}

	/////////////////////

	function spawn_particles(tag)
	{
		if (!tag.TargetTile.IsVisibleForPlayer) return;

		if (::Const.Tactical.RaiseUndeadParticles.len() != 0)
		{
			for( local i = 0; i < ::Const.Tactical.RaiseUndeadParticles.len(); i = i )
			{
				this.Tactical.spawnParticleEffect(true, ::Const.Tactical.RaiseUndeadParticles[i].Brushes, tag.TargetTile, ::Const.Tactical.RaiseUndeadParticles[i].Delay, ::Const.Tactical.RaiseUndeadParticles[i].Quantity, ::Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, ::Const.Tactical.RaiseUndeadParticles[i].SpawnRate, ::Const.Tactical.RaiseUndeadParticles[i].Stages);
				i = ++i;
			}
		}
	}

	////////////////////

	function onCombatStarted()
	{
		this.m.Used = false;
	}

	function onCombatFinished()
	{
		this.m.Used = false;
	}

	//Tooltips
	function custom_tooltip(ret)
	{
		ret.push({
			id = 3,
			type = "text",
			icon = "ui/tooltips/blank.png",
			text = this.m.Name_
		});

		local t = this.m.Type_ == "scripts/entity/tactical/enemies/flesh_abomination" ? "Melee" : "Ranged";
		ret.push({
			id = 3,
			type = "text",
			icon = "ui/tooltips/blank.png",
			text = "Type: " + t
		});

		//stats
		ret.push({
			id = 3,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::MSU.Text.colorRed("Stats: ")
		});
		ret.push({
			id = 101,
			type = "hint",
			icon = "ui/icons/bravery.png",
			text = "" + this.m.BaseProperties.Bravery
		});
		ret.push({
			id = 102,
			type = "hint",
			icon = "ui/icons/initiative.png",
			text = "" + this.m.BaseProperties.Initiative
		});
		ret.push({
			id = 103,
			type = "hint",
			icon = "ui/icons/melee_skill.png",
			text = "" + this.m.BaseProperties.MeleeSkill
		});
		ret.push({
			id = 104,
			type = "hint",
			icon = "ui/icons/ranged_skill.png",
			text = "" + this.m.BaseProperties.RangedSkill
		});
		ret.push({
			id = 105,
			type = "hint",
			icon = "ui/icons/melee_defense.png",
			text = "" + this.m.BaseProperties.MeleeDefense
		});
		ret.push({
			id = 106,
			type = "hint",
			icon = "ui/icons/ranged_defense.png",
			text = "" + this.m.BaseProperties.RangedDefense
		});
		try {
			ret.push({
				id = 106,
				type = "hint",
				icon = "ui/icons/armor_head.png",
				text = "" + this.m.BaseProperties.Armor[0]
			});

			ret.push({
				id = 106,
				type = "hint",
				icon = "ui/icons/armor_body.png",
				text = "" + this.m.BaseProperties.Armor[1]
			});
		}catch(exception){}

		//skills

		ret.push({
			id = 3,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::MSU.Text.colorRed("Skills: ")
		});

		foreach(skill in this.m.Skills)
		{
			ret.push({
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = skill.m.Name
			});
		}
		return ret;
	}



	////////////////////////

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeString(this.m.Name_);
		_out.writeString(this.m.Type_);
		_out.writeI16(this.m.Absorbed);

		::MSU.Utils.serialize(this.m.BaseProperties, _out);

		local scripts = [];
		foreach(skill in this.m.Skills)
		{
			if (skill.m.ID in ::Z.Map)
				scripts.push(::Z.Map[skill.m.ID]);
		}
		::MSU.Utils.serialize(scripts, _out);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.Name_ = _in.readString();
		this.m.Type_ = _in.readString();
		this.m.Absorbed = _in.readI16();

		this.m.BaseProperties = ::MSU.Utils.deserialize(_in);
		local scripts = ::MSU.Utils.deserialize(_in);
		foreach(script in scripts)
		{
			this.m.Skills.push(::new(script));
		}
	}



});

