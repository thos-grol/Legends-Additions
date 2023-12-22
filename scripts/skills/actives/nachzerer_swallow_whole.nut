this.nachzerer_swallow_whole <- this.inherit("scripts/skills/skill", {
	m = {
		SwallowedEntity = null,
		SwallowedItems = [],
		SwallowedEntity_HP = 0,
		Cooldown = 2
	},
	function onTurnStart()
	{
		if (this.m.SwallowedEntity != null) return;
		this.m.Cooldown = ::Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.SwallowedEntity == null && this.m.Cooldown == 0;
	}

	function create()
	{
		this.m.ID = "actives.nachzerer_swallow_whole";
		this.m.Name = "Swallow Whole";
		this.m.Description = "";
		this.m.Icon = "skills/active_103.png";
		this.m.IconDisabled = "skills/active_103.png";
		this.m.Overlay = "active_103";
		this.m.SoundOnHit = [
			"sounds/enemies/swallow_whole_01.wav",
			"sounds/enemies/swallow_whole_02.wav",
			"sounds/enemies/swallow_whole_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/enemies/swallow_whole_miss_01.wav",
			"sounds/enemies/swallow_whole_miss_02.wav",
			"sounds/enemies/swallow_whole_miss_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local target = _targetTile.getEntity();
		local brothers = this.Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);

		if (target == null) return false;
		if (target.getFlags().has("IsSummoned")) return false;
		if (_targetTile.getEntity().isPlayerControlled() && brothers.len() == 1) return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab;
	}

	function onTurnEnd()
	{
		if (this.m.SwallowedEntity == null) return;

		local damage = ::Math.rand(10, 20);
		local prev = this.m.SwallowedEntity_HP;
		this.m.SwallowedEntity_HP = ::Math.max(0, this.m.SwallowedEntity_HP - damage);
		local actor = this.getContainer().getActor();

		if (this.m.SwallowedEntity_HP > 0)
		{
			actor.setHitpoints(::Math.min(actor.getHitpointsMax(), actor.getHitpoints() + damage));

			::Tactical.EventLog.log(
				::Const.UI.getColorizedEntityName(this.m.SwallowedEntity) + " "
				 + "[Swallowed]"
				 + " » " + ::MSU.Text.color(::Z.Color.BloodRed, prev) + " › " + ::MSU.Text.color(::Z.Color.BloodRed, this.m.SwallowedEntity_HP)
				 + " ([b]" + ::MSU.Text.color(::Z.Color.BloodRed, damage) + "[/b])"
			);
			::Tactical.EventLog.logIn(
				::Const.UI.getColorizedEntityName(actor) + " heals " + damage + " hitpoints.\n\n"
			);
		}
		else
		{
			//handle items
			local digested_items = this.m.SwallowedEntity.getItems().getAllItems();
			foreach(digested_item in digested_items)
			{
				digested_item.setContainer(null);
				digested_item.setCurrentSlotType(::Const.ItemSlot.None);
			}
			this.m.SwallowedItems.extend(digested_items);

			//handle death
			local is_player_controlled = this.m.SwallowedEntity.isPlayerControlled();
			local is_guest;
			try
			{
				is_guest = this.m.SwallowedEntity.isGuest();
			}catch(execption)
			{
				is_guest = null;
			}

			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.m.SwallowedEntity) + " has been digested.");
			this.m.SwallowedEntity.getSkills().onDeath(::Const.FatalityType.Devoured);
			this.m.SwallowedEntity.onDeath(null, null, null, ::Const.FatalityType.Devoured);
			this.World.getPlayerRoster().remove(this.m.SwallowedEntity);
			this.m.SwallowedEntity = null;

			if (!this.Tactical.State.isScenarioMode() && is_player_controlled && (is_guest == null || !is_guest))
			{
				local roster = this.World.getPlayerRoster().getAll();
				foreach( bro in roster )
				{
					if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
					{
						if (this.World.Assets.getOrigin().getID() != "scenario.manhunters" && bro.getBackground().getID() != "background.slave")
						{
							bro.worsenMood(::Const.MoodChange.BrotherDied, this.getName() + " died in battle");
						}
					}
				}
			}



			//Counts as feasted, remove temp injuries
			local skills = this.m.Container.getAllSkillsOfType(::Const.SkillType.Injury);
			foreach( s in skills )
			{
				if (s.getOrder() == ::Const.SkillOrder.PermanentInjury) continue;
				s.removeSelf();
			}

			//add 2 stacks of hair armor
			local nachzerer_hair_armor = this.m.Container.getSkillByID("perk.class.gluttony_knight");
			if (nachzerer_hair_armor != null) nachzerer_hair_armor.addCharges(2);
		}

		actor.setHitpoints(::Math.min(actor.getHitpoints() + damage, actor.getHitpointsMax()));
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		local target = _targetTile.getEntity();
		local roll = ::Math.rand(1, 100);
		local chance = ::Math.min(100, _user.getCurrentProperties().getMeleeSkill() - target.getCurrentProperties().getMeleeDefense() + 30);
		local dodgeCheck = roll <= chance;
		if (!dodgeCheck)
		{
			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || this.knockToTile.IsVisibleForPlayer))
				::Z.Log.skill(_user, target, "Swallow Whole", roll, chance, false, true);

			local nachzerer_maddening_hunger = _user.getSkills().getSkillByID("effects.nachzerer_maddening_hunger");
			if (nachzerer_maddening_hunger == null) _user.getSkills().add(::new("scripts/skills/effects/nachzerer_maddening_hunger"));
			else nachzerer_maddening_hunger.addStacks(1);

			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || this.knockToTile.IsVisibleForPlayer))
			::Z.Log.skill(_user, target, "Swallow Whole", roll, chance, false, true);

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		skills.removeByID("effects.legend_vala_chant_disharmony_effect");
		skills.removeByID("effects.legend_vala_chant_fury_effect");
		skills.removeByID("effects.legend_vala_chant_senses_effect");
		skills.removeByID("effects.legend_vala_currently_chanting");
		skills.removeByID("effects.legend_vala_in_trance");

		::Tactical.getTemporaryRoster().add(target);
		::Tactical.TurnSequenceBar.removeEntity(target);
		this.m.SwallowedEntity = target;
		this.m.SwallowedEntity.getFlags().set("Devoured", true);
		this.m.SwallowedEntity_HP = target.getHitpoints();
		target.removeFromMap();
		_user.getSprite("body").setBrush("bust_ghoul_body_04");
		_user.getSprite("injury").setBrush("bust_ghoul_04_injured");
		_user.getSprite("head").setBrush("bust_ghoul_04_head_0" + _user.m.Head);
		_user.m.Sound[::Const.Sound.ActorEvent.Death] = _user.m.Sound[::Const.Sound.ActorEvent.Other2];
		local effect = ::new("scripts/skills/effects/swallowed_whole_effect");
		effect.setName(target.getName());
		_user.getSkills().add(effect);

		//Remove maddening hunger
		_user.getSkills().removeByID("effects.nachzerer_maddening_hunger");

		if (this.m.SoundOnHit.len() != 0)
			this.Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());

		return true;
	}

	function getSwallowedEntity()
	{
		return this.m.SwallowedEntity;
	}

	function getSwallowedItems()
	{
		return this.m.SwallowedItems;
	}

});

