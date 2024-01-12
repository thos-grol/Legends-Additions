this.legend_mark_target <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_mark_target";
		this.m.Name = "Mark Target";
		this.m.Description = "Analyse the weak points on an opponent and tell your comrades, reducing the targets ranged defense by 20 for 3 turns";
		this.m.KilledString = "Marked";
		this.m.Icon = "skills/MarkTargetSkill.png";
		this.m.IconDisabled = "skills/MarkTargetSkill_bw.png";
		this.m.Overlay = "mark_target";
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsRanged = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MaxLevelDifference = 6;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Leave your opponent marked, reducing their ranged defense by 20"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);

		if (target.isAlive())
		{
			target.getSkills().add(this.new("scripts/skills/effects/legend_marked_target"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " calls and singles out " + ::Const.UI.getColorizedEntityName(target) + " leaving them marked");
			}
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		return true;
	}

});

