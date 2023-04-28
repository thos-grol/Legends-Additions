//Net mastery perk now allows npcs to refill their nets. Bags and belts grants npc 2 more nets.
::Const.Strings.PerkDescription.LegendMasteryNets = "Reduce the fatigue cost of throwing nets by" + ::MSU.Text.colorGreen( "25" ) + "% and reduce AP cost to" + ::MSU.Text.colorGreen( "3" ) + ". Gain a free action to equip or switch a net.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMasteryNets].Tooltip = ::Const.Strings.PerkDescription.LegendMasteryNets;

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

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.ThrowNet) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
			agent.finalizeBehaviors();
		}
	}

});

//Add code for npc to draw new nets
::mods_hookExactClass("skills/actives/throw_net", function (o)
{
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
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to net " + ::Const.UI.getColorizedEntityName(targetEntity) + ", the net falls to the ground");
			}
			_user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand).drop();

            if (_user.getFaction() != ::Const.Faction.Player && _user.getSkills().hasSkill("perk.legend_mastery_nets"))
            {
                local net_mastery = _user.getSkills().getSkillByID("perk.legend_mastery_nets");
                net_mastery.refill();
            }



			return false;
		}
		else
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Ranged Defense with -10 modifier, rolled " + roll + " vs " + chance);

			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " throws a net and hits " + ::Const.UI.getColorizedEntityName(targetEntity));
			}

			_user.getItems().unequip(_user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand));
			targetEntity.getSkills().add(::new("scripts/skills/effects/net_effect"));
			local breakFree = ::new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			if (this.m.IsReinforced)
			{
				breakFree.setDecal("net_destroyed_02");
				breakFree.setChanceBonus(-15);
				local r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.World.Assets.getStash().add(::new("scripts/items/tools/legend_broken_throwing_net"));
				}
				else
				{
					this.World.Assets.getStash().add(::new("scripts/items/tools/reinforced_throwing_net"));
				}
			}
			else
			{
				breakFree.setDecal("net_destroyed");
				breakFree.setChanceBonus(0);
				local chance = this.Math.rand(1, 100);

				if (chance > 25)
				{
					this.World.Assets.getStash().add(::new("scripts/items/tools/legend_broken_throwing_net"));
				}
			}

			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = this.m.IsReinforced
			});

            if (_user.getFaction() != ::Const.Faction.Player && _user.getSkills().hasSkill("perk.legend_mastery_nets"))
            {
                local net_mastery = _user.getSkills().getSkillByID("perk.legend_mastery_nets");
                net_mastery.refill();
            }
		}

	}
});

//Add code to dodge spider webs, melee defense - 10
::mods_hookExactClass("skills/actives/web_skill", function (o)
{
	o.onUse = function( _user, _targetTile )
	{
		this.m.Cooldown = 3;
		local targetEntity = _targetTile.getEntity();

		local roll = this.Math.rand(1, 100);
		local chance = this.Math.min(100, _user.getCurrentProperties().getMeleeDefense() - 10);

		local dodgeCheck = targetEntity.getSkills().hasSkill("perk.legend_escape_artist") &&  roll <= chance;

		if (targetEntity.getCurrentProperties().IsImmuneToRoot || dodgeCheck)
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to web " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Melee Defense with -10 modifier, rolled " + roll + " vs " + chance);
			}

			return false;
		}
		else
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			targetEntity.getSkills().add(::new("scripts/skills/effects/web_effect"));
			local breakFree = ::new("scripts/skills/actives/break_free_skill");
			breakFree.setDecal("web_destroyed");
			breakFree.m.Icon = "skills/active_113.png";
			breakFree.m.IconDisabled = "skills/active_113_sw.png";
			breakFree.m.Overlay = "active_113";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect("bust_web2", this.createColor("#ffffff"), _targetTile, 0, 4, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), targetEntity);

			if (targetEntity.getSkills().hasSkill("perk.legend_escape_artist"))
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " webs " + ::Const.UI.getColorizedEntityName(targetEntity) + ". Using Melee Defense with -10 modifier, rolled " + roll + " vs " + chance);

			}
			else
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " webs " + ::Const.UI.getColorizedEntityName(targetEntity));
			}
			return true;
		}
	}

});

//Add code to dodge roots, over ptr code
::mods_hookExactClass("skills/actives/root_skill", function(o) {
	o.onUse = function( _user, _targetTile )
	{
		local targets = [];

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();

			if (this.isViableTarget(_user, entity))
			{
				targets.push(entity);
			}
		}

		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local adjacent = _targetTile.getNextTile(i);

				if (adjacent.IsOccupiedByActor)
				{
					local entity = adjacent.getEntity();

					if (this.isViableTarget(_user, entity))
					{
						targets.push(entity);
					}
				}
			}

			i = ++i;
		}

		foreach( target in targets )
		{

			local roll = this.Math.rand(1, 100);
			local chance = this.Math.min(100, _user.getCurrentProperties().getMeleeDefense() - 10);
			local dodgeCheck = target.getSkills().hasSkill("perk.legend_escape_artist") &&  roll <= chance;

			if (!dodgeCheck)
			{
				target.getSkills().add(::new("scripts/skills/effects/rooted_effect"));
				local breakFree = ::new("scripts/skills/actives/break_free_skill");
				breakFree.setDecal("roots_destroyed");
				breakFree.m.Icon = "skills/active_75.png";
				breakFree.m.IconDisabled = "skills/active_75_sw.png";
				breakFree.m.Overlay = "active_75";
				breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
				target.getSkills().add(breakFree);
				target.raiseRootsFromGround("bust_roots", "bust_roots_back");

				if (target.getSkills().hasSkill("perk.legend_escape_artist"))
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " roots " + ::Const.UI.getColorizedEntityName(target) + ". Using Melee Defense with -10 modifier, rolled " + roll + " vs " + chance);
				}
			}
			else
			{
				if (target.getSkills().hasSkill("perk.legend_escape_artist"))
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " fails to root " + ::Const.UI.getColorizedEntityName(target) + ". Using Melee Defense with -10 modifier, rolled " + roll + " vs " + chance);
				}
			}
		}

		if (targets.len() > 0 && this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, this.targetEntity.getPos());
		}

		this.m.Cooldown = 3;
		return true;

	}
});