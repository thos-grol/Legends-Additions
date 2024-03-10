this.cultist_pain_ritual <- this.inherit("scripts/skills/skill", {
	m = {
		EffectAdded = false
	},
	function create()
	{
		this.m.ID = "actives.pain_ritual";
		this.m.Name = "Pain Ritual";
		this.m.Description = "Use the equipped weapon to self-inflect grievious injury. The user and their target will share the pain and injury.";
		this.m.KilledString = "Cursed by Pain Ritual";
		this.m.Icon = "skills/pain_ritual.png";
		this.m.IconDisabled = "skills/pain_ritual_bw.png";
		this.m.Overlay = "pain_ritual";
		this.m.SoundOnUse = [];
		this.m.SoundOnHit = [];
		this.m.SoundOnHitShield = [];
		this.m.SoundOnMiss = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 6;
		this.m.IsVisibleTileNeeded = true;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		return ret;
	}

	function isUsable()
	{
		if (!this.Tactical.isActive() || !this.skill.isUsable()) return false;
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (weapon == null) return false;
		if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Dagger)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Spear)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Axe)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Dagger)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Sword)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Flail)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Hammer)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Mace)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Staff)
		) return true;

		return false;
	}

    function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();
		local hitInfo = this.getHitInfo(target);
		this.Sound.play("sounds/cultist/disembowl.wav", 200.0, _user.getPos(), ::Math.rand(95, 105) * 0.01);

		::Z.Log.skill(_user, target, this.m.Name, 0, 0, "", true, false);

		local injury_id = addInjury(actor, hitInfo );
		local injury = ::new(injury_id);
		if (injury_id != null && target.m.CurrentProperties.IsAffectedByInjuries && target.m.IsAbleToDie)
			target.m.Skills.add(injury);

		::Z.Log.suffer_injury(_user, injury.m.Name);
		::Z.Log.suffer_injury(target, injury.m.Name);

		actor.onDamageReceived(actor, this, hitInfo);
		target.onDamageReceived(actor, this, hitInfo);

		return true;
	}

	function addInjury( target, hitInfo )
	{
		if (target.m.CurrentProperties.IsAffectedByInjuries && target.m.IsAbleToDie)
		{
			local potentialInjuries = [];
			foreach( inj in hitInfo.Injuries )
			{
				if (!target.m.Skills.hasSkill(inj.ID) && target.m.ExcludedInjuries.find(inj.ID) == null)
				{
					potentialInjuries.push(inj.Script);
				}
			}

			while (potentialInjuries.len() != 0)
			{
				local r = ::Math.rand(0, potentialInjuries.len() - 1);
				local injury = ::new("scripts/skills/" + potentialInjuries[r]);

				if (injury.isValid(target))
				{
					target.m.Skills.add(injury);
					if (target.isPlayerControlled() && this.isKindOf(this, "player"))
					{
						target.worsenMood(::Const.MoodChange.Injury, "Suffered an injury");
						if (("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_sacrifice") this.World.Statistics.getFlags().increment("OathtakersInjuriesSuffered");
					}
					return "scripts/skills/" + potentialInjuries[r];
				}
				else potentialInjuries.remove(r);
			}
		}
		return null;
	}

	function getHitInfo( target )
	{
		local injury_array = target.getFlags().has("skeleton") ? [::Const.Injury.SkeletonBody, ::Const.Injury.SkeletonHead] : getInjuryType();

		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		local p = this.getContainer().buildPropertiesForUse(this, null);

		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = ::Math.rand(weapon.m.RegularDamage, weapon.m.RegularDamageMax) * p.MeleeDamageMult;
		hitInfo.DamageDirect = 1.0;
		if (::Math.rand(1, 100) <= 50)
		{
			hitInfo.Injuries = injury_array[0]; //body
			hitInfo.BodyPart = ::Const.BodyPart.Body;
		}
		else
		{
			hitInfo.Injuries = injury_array[1]; //head
			hitInfo.BodyPart = ::Const.BodyPart.Head;
		}
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.InjuryThresholdMult = 0;
		return hitInfo;
	}

	function getInjuryType()
	{
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Dagger)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Spear)
		) return [::Const.Injury.PiercingBody, ::Const.Injury.PiercingHead];
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Axe)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Dagger)
			|| weapon.isWeaponType(::Const.Items.WeaponType.Sword)
		) return [::Const.Injury.CuttingBody, ::Const.Injury.CuttingHead];
		else
		{
			return [::Const.Injury.BluntBody, ::Const.Injury.BluntHead];
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.PainRitual) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_pain_ritual"));
			agent.finalizeBehaviors();
		}
	}

	function addSprite( _n, _brush, _insert = false )
	{
		local actor = this.getContainer().getActor();
		local sprite;

		if (!_insert)
		{
			sprite = actor.addSprite("spirits_" + (_n < 10 ? "0" + _n : _n));
		}
		else
		{
			sprite = actor.insertSprite("spirits_" + (_n < 10 ? "0" + _n : _n));
		}

		sprite.setBrush(_brush);
		sprite.Rotation = this.Math.rand(0, 359);
		actor.setSpriteRenderToTexture("spirits_" + (_n < 10 ? "0" + _n : _n), false);
	}

	function onTurnStart()
	{
		if (this.m.EffectAdded) return;

		this.m.EffectAdded = true;

		this.addSprite(1, "pain_aura");
		this.addSprite(2, "pain_aura", true);
	}

	function onCombatFinished()
	{
		this.m.EffectAdded = false;
		local actor = this.getContainer().getActor();
		actor.removeSprite("spirits_01");
		actor.removeSprite("spirits_02");
	}

});