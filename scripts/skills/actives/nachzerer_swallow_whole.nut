this.nachzerer_swallow_whole <- this.inherit("scripts/skills/skill", {
	m = {
		SwallowedEntity = null,
		SwallowedItems = [],
		SwallowedEntity_HP = 0,
		Cooldown = 2
	},
	function getSwallowedEntity()
	{
		return this.m.SwallowedEntity;
	}

	function onTurnStart()
	{
		if (this.m.SwallowedEntity != null) return;
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
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
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
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
		local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		if (target == null) return false;
		if (target.getFlags().has("IsSummoned")) return false;
		if (_targetTile.getEntity().isPlayerControlled() && brothers.len() == 1) return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab;
	}

	function onTurnEnd()
	{
		if (this.m.SwallowedEntity == null) return;

		local damage = this.Math.rand(10, 20);
		this.m.SwallowedEntity_HP = this.Math.max(0, this.m.SwallowedEntity_HP - damage);
		local actor = this.getContainer().getActor();
		
		if (this.m.SwallowedEntity_HP > 0)
		{
			actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + damage));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.SwallowedEntity) + " takes " + damage + " damage. They have " + this.m.SwallowedEntity_HP + " remaining.\n" + this.Const.UI.getColorizedEntityName(actor) + " gains " + damage + " hitpoints.");
		}
		else
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.SwallowedEntity) + " has been digested.");
			this.m.SwallowedEntity.getSkills().onDeath(this.Const.FatalityType.Devoured);
			this.m.SwallowedEntity.onDeath(null, null, null, this.Const.FatalityType.Devoured);
			this.World.getPlayerRoster().remove(this.m.SwallowedEntity);
			this.m.SwallowedEntity = null;

			//TODO: bro death effects ie. party mood
			
			//TODO: loop through all items and save it to this.m.SwallowedItems

			//Counts as feasted, remove temp injuries
			local skills = actor.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury);
			foreach( s in skills )
			{
				if (s.getOrder() == ::Const.SkillOrder.PermanentInjury) continue;
				s.removeSelf();
			}

			//add 2 stacks of hair armor
			local nachzerer_hair_armor = actor.getSkills().getSkillByID("perk.nachzerer_hair_armor");
			if (nachzerer_hair_armor != null) nachzerer_hair_armor.addCharges(2);
		}

		actor.setHitpoints(this.Math.min(actor.getHitpoints() + damage, actor.getHitpointsMax()));
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		local target = _targetTile.getEntity();
		local roll = this.Math.rand(1, 100);
		local chance = this.Math.min(100, _user.getCurrentProperties().getMeleeSkill() - target.getCurrentProperties().getMeleeDefense() + 30);
		local dodgeCheck = roll <= chance;
		if (!dodgeCheck)
		{
			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || this.knockToTile.IsVisibleForPlayer))
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " tries to devour " + this.Const.UI.getColorizedEntityName(target) + " but misses. Rolled " + roll + " vs " + chance);

			local nachzerer_maddening_hunger = _user.getSkills().getSkillByID("effects.nachzerer_maddening_hunger");
			if (nachzerer_maddening_hunger == null) _user.getSkills().add(this.new("scripts/skills/effects/nachzerer_maddening_hunger"));
			else nachzerer_maddening_hunger.addStacks(1);

			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || this.knockToTile.IsVisibleForPlayer))
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " devours " + this.Const.UI.getColorizedEntityName(target) + "Rolled " + roll + " vs " + chance);

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		skills.removeByID("effects.legend_vala_chant_disharmony_effect");
		skills.removeByID("effects.legend_vala_chant_fury_effect");
		skills.removeByID("effects.legend_vala_chant_senses_effect");
		skills.removeByID("effects.legend_vala_currently_chanting");
		skills.removeByID("effects.legend_vala_in_trance");

		this.m.SwallowedEntity = target;
		this.m.SwallowedEntity.getFlags().set("Devoured", true);
		this.m.SwallowedEntity_HP = target.getHitpoints();
		target.removeFromMap();
		_user.getSprite("body").setBrush("bust_ghoul_body_04");
		_user.getSprite("injury").setBrush("bust_ghoul_04_injured");
		_user.getSprite("head").setBrush("bust_ghoul_04_head_0" + _user.m.Head);
		_user.m.Sound[this.Const.Sound.ActorEvent.Death] = _user.m.Sound[this.Const.Sound.ActorEvent.Other2];
		local effect = this.new("scripts/skills/effects/swallowed_whole_effect");
		effect.setName(target.getName());
		_user.getSkills().add(effect);

		//Remove maddening hunger
		_user.getSkills().removeByID("effects.nachzerer_maddening_hunger");

		if (this.m.SoundOnHit.len() != 0)
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());

		return true;
	}

});

