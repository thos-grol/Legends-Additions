this.nachzerer_swallow_whole_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SwallowedEntity = null
	},
	function getSwallowedEntity()
	{
		return this.m.SwallowedEntity;
	}

	function create()
	{
		this.m.ID = "actives.swallow_whole";
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
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.SwallowedEntity == null;
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
		local hp = this.m.SwallowedEntity.getHitpoints();
		local damage = this.Math.rand(10, 20);
		hp = this.Math.max(0, hp - damage);

		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.SwallowedEntity) + " takes " + damage + " damage. They have " + hp + " remaining.");

		if (hp > 0) this.m.SwallowedEntity.setHitpoints(hp);
		else
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.SwallowedEntity) + " has been digested.");
			bro.getSkills().onDeath(this.Const.FatalityType.Devoured);
			bro.onDeath(null, null, null, this.Const.FatalityType.Devoured);
			this.World.getPlayerRoster().remove(bro);

			//TODO: heal nacho injuries. And additional effect.
		}
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || this.knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " devours " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		skills.removeByID("effects.legend_vala_chant_disharmony_effect");
		skills.removeByID("effects.legend_vala_chant_fury_effect");
		skills.removeByID("effects.legend_vala_chant_senses_effect");
		skills.removeByID("effects.legend_vala_currently_chanting");
		skills.removeByID("effects.legend_vala_in_trance");

		if (target.getMoraleState() != this.Const.MoraleState.Ignore) target.setMoraleState(this.Const.MoraleState.Breaking);

		this.m.SwallowedEntity = target;
		this.m.SwallowedEntity.getFlags().set("Devoured", true);
		target.removeFromMap();
		_user.getSprite("body").setBrush("bust_ghoul_body_04");
		_user.getSprite("injury").setBrush("bust_ghoul_04_injured");
		_user.getSprite("head").setBrush("bust_ghoul_04_head_0" + _user.m.Head);
		_user.m.Sound[this.Const.Sound.ActorEvent.Death] = _user.m.Sound[this.Const.Sound.ActorEvent.Other2];
		local effect = this.new("scripts/skills/effects/swallowed_whole_effect");
		effect.setName(target.getName());
		_user.getSkills().add(effect);

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		return true;
	}

});

