//rework net mastery to refill nets
::mods_hookExactClass("skills/perks/perk_legend_mastery_nets", function (o)
{
    o.m.Count <- 0;
    o.m.Refill <- false;

    o.create = function()
	{
		this.m.ID = "perk.legend_mastery_nets";
		this.m.Name = ::Const.Strings.PerkName.LegendMasteryNets;
		this.m.Description = ::Const.Strings.PerkDescription.LegendMasteryNets;
		this.m.Icon = "ui/perks/net_perk.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
        this.m.Count = this.Math.rand(0, 2);
	}

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		//TODO: add logic
		//add net to bro if he has none

		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.ThrowNet) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
			agent.finalizeBehaviors();
		}
	}

	o.onCombatStarted <- function()
	{
		//TODO: add logic
		//add net to bro if he has none and minus it from the count.
	}

	o.onCombatFinished <- function()
	{
		//TODO: add logic
		//add net to bro if he has none
	}

	

    o.onTurnEnd <- function()
	{
        if (this.m.Refill)
        {
            this.getContainer().getActor().m.Items.equip(::new("scripts/items/tools/throwing_net"));
            this.m.Refill = false;
            this.m.Count -= 1;
        }
	}

    o.refill <- function()
    {
        if (this.m.Count > 0) this.m.Refill = true;
    }

	o.m.IsSpent <- true;

	o.getItemActionCost <- function(_items)
	{
		if (this.m.IsSpent) return null;

		local validItemsCount = 0;

		foreach (i in _items)
		{
			if (i == null) continue;
			if (i.getSlotType() == ::Const.ItemSlot.Mainhand) return null;
			if (i.m.ID == "tool.throwing_net" || i.m.ID == "tool.reinforced_throwing_net") validItemsCount++;
			else return null;
		}

		if (validItemsCount > 0) return 0;
		return null;
	}

	o.onTurnStart <- function()
	{
		this.m.IsSpent = false;
	}

	o.onCombatFinished <- function()
	{
		this.m.IsSpent = true;
	}

	o.onPayForItemAction <- function(_skill, _items)
	{
		if (_skill != null && _skill.getID() != "perk.ptr_target_practice") this.m.IsSpent = true;
	}

});

//======================================================================================================================

::mods_hookExactClass("skills/actives/throw_net", function (o)
{
    //rework nets to be dodgeable with escape artist perk
    //remove net drops
    //add logic to refill nets based on net mastery
    o.onUse = function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local roll = this.Math.rand(1, 100);
		local chance = this.Math.min(100, _user.getCurrentProperties().getRangedDefense() - 10);
		local dodgeCheck = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") &&  roll <= chance;
        
        if (targetEntity.getCurrentProperties().IsImmuneToRoot || dodgeCheck)
        {
			if (this.m.SoundOnMiss.len() != 0) this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());

            if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to net " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Ranged Defense with -10 modifier, rolled " + roll + " vs " + chance + ", the net falls to the ground");
			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to net immune target " + ::Const.UI.getColorizedEntityName(targetEntity) + ", the net falls to the ground");
			}

			_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop();
            if (_user.getSkills().hasSkill("perk.legend_mastery_nets"))
            {
                local net_mastery = _user.getSkills().getSkillByID("perk.legend_mastery_nets");
                net_mastery.refill();
            }
			return false;
		}
        else
		{
			if (this.m.SoundOnHit.len() != 0) this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Ranged Defense with -10 modifier, rolled " + roll + " vs " + chance);

			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + ::Const.UI.getColorizedEntityName(targetEntity));
			}
			
            _user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop();
            if (_user.getSkills().hasSkill("perk.legend_mastery_nets"))
            {
                local net_mastery = _user.getSkills().getSkillByID("perk.legend_mastery_nets");
                net_mastery.refill();
            }

			targetEntity.getSkills().add(this.new("scripts/skills/effects/net_effect"));
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			if (this.m.IsReinforced)
			{
				breakFree.setDecal("net_destroyed_02");
				breakFree.setChanceBonus(-15);
			}
			else
			{
				breakFree.setDecal("net_destroyed");
				breakFree.setChanceBonus(0);
			}
			targetEntity.getSkills().add(breakFree);

			local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = this.m.IsReinforced
			});
		}
		
	}
});