this.cultist_compassion_ritual <- this.inherit("scripts/skills/skill", {
	m = {
		isWindow = false
	},
	function create()
	{
		this.m.ID = "actives.compassion_ritual";
		this.m.Name = "Compassion Ritual";
		this.m.Description = "All Dharmas are forms of emptiness...";
		this.m.Icon = "skills/compassion_ritual.png";
		this.m.IconDisabled = "skills/compassion_ritual_bw.png";
		this.m.Overlay = "compassion_ritual";
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
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 13;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This skill can be used only at random times."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Give the target your permanent injuries. While either you are the target is still alive, the effect lasts. You cannot cast this skill again until then."
			}
		];
		return ret;
	}

    function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();
		this.Sound.play("sounds/cultist/compassion_ritual.wav", 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);
		this.m.isWindow = false;
		addInjuries(target);
		return true;
	}

	function addInjuries(target)
	{
		if (target.m.CurrentProperties.IsAffectedByInjuries && target.m.IsAbleToDie)
		{
			local actor = this.getContainer().getActor();
			local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
			local injury_IDs = {};
			local injuries = [];

			//find the user's permanent injuries
			foreach( s in skills )
			{
				if (s.isType(::Const.SkillType.PermanentInjury)) injury_IDs[s.m.ID] <- true;
			}

			//get the scripts to add
			foreach( s in ::Const.Injury.Permanent )
			{
				if (target.m.Skills.hasSkill(s.ID)) continue;
				if (s.ID in injury_IDs) injuries.push(s.Script);
			}

			foreach( script in injuries )
			{
				this.logInfo("Logging injuries to add");
				this.logInfo(script);
			}

			//add the injuries with temp modifier
			foreach( script in injuries )
			{
				local injury = ::new("scripts/skills/" + script);
				injury.m.IsRemovedAfterBattle = true;
				target.m.Skills.add(injury);
			}

			//add master/slave logic
			local color;
			do
			{
				color = this.createColor("#ff0000");
				color.varyRGB(0.75, 0.75, 0.75);
			}
			while (color.R + color.G + color.B <= 150);

			this.Tactical.spawnSpriteEffect("compassion_effect", color, target.getTile(), !target.getSprite("status_compassion").isFlippedHorizontally() ? 10 : -5, 88, 3.0, 1.0, 0, 400, 300);
			local slave = ::new("scripts/skills/effects/cultist_compassion_slave");
			local master = ::new("scripts/skills/effects/cultist_compassion_master");
			slave.setMaster(master);
			slave.setColor(color);
			target.getSkills().add(slave);
			master.setSlave(slave);
			master.setColor(color);
			actor.getSkills().add(master);
			slave.activate();
			master.activate();
			target.playSound(::Const.Sound.ActorEvent.Death, ::Const.Sound.Volume.Actor * target.m.SoundVolume[::Const.Sound.ActorEvent.Death] * target.m.SoundVolumeOverall, target.m.SoundPitch);
		}
	}

	function getInjuryBonus()
	{
		local actor = this.getContainer().getActor();
        local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
		local count = 0;
        foreach( s in skills )
        {
            if (s.isType(::Const.SkillType.PermanentInjury)) count += 1;
        }
		return count * 4;

	}

	function isUsable()
	{
		if (!this.Tactical.isActive() || !this.skill.isUsable()) return false;
		if (this.getContainer().getActor().getSkills().hasSkill("effects.compassion_master")) return false;
		return this.m.isWindow;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
		local target = _targetTile.getEntity();
		return !target.getSkills().hasSkill("effects.compassion_slave");
	}

	function onTurnStart()
	{
		if (this.Math.rand(1,100) <= 13 + getInjuryBonus()) this.m.isWindow = true;
	}

	function onTurnEnd()
	{
		this.m.isWindow = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.CompassionRitual) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_compassion_ritual"));
			agent.finalizeBehaviors();
		}
	}

});