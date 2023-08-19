//Reinforced Nets
//  - When replacing nets, all the nets will now be reinforced nets, making it 20% harder to break free.
//	- TODO: fix description of reinforced nets to 20% harder to break free.

//rework net mastery to refill nets
::Const.Strings.PerkName.LegendNetRepair = "Net Specialization"
::Const.Strings.PerkDescription.LegendNetRepair = "Many years and storms weathered with a net in hand..."
+ "\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]"
+ "\n• Gain 3 nets. Start the battle off with one, and if this brother ends their turn with their offhand empty, will automatically replace their thrown nets."
+ "\n• Grants +10 melee defense while holding a net.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendNetRepair].Name = ::Const.Strings.PerkName.LegendNetRepair;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendNetRepair].Tooltip = ::Const.Strings.PerkDescription.LegendNetRepair;

::mods_hookExactClass("skills/perks/perk_legend_net_repair", function (o)
{
    o.m.Count <- 0;
    o.m.Refill <- false;

    o.create = function()
	{
		this.m.ID = "perk.legend_net_repair";
		this.m.Name = this.Const.Strings.PerkName.LegendNetRepair;
		this.m.Description = this.Const.Strings.PerkDescription.LegendNetRepair;
		this.m.Icon = "ui/perks/net_perk.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
        this.m.Count = 2;
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

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item == null) return
		if (item.getID() == "tool.throwing_net" || item.getID() == "tool.reinforced_throwing_net")
		{
			_properties.MeleeDefense += 10;
		}
	}

    o.refill <- function()
    {
        if (this.m.Count > 0) this.m.Refill = true;
    }

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();

		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item == null) this.getContainer().getActor().m.Items.equip(::new("scripts/items/tools/throwing_net"));

		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.ThrowNet) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
			agent.finalizeBehaviors();
		}
	}

	o.onCombatFinished <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled()) return;

		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item == null) this.getContainer().getActor().m.Items.equip(::new("scripts/items/tools/throwing_net"));
	}

	o.onCombatStarted <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("perk.legend_net_casting")) this.m.Count = 3;
	}

});

//======================================================================================================================

::Const.Strings.PerkName.LegendNetCasting = "Net Arsenal"
::Const.Strings.PerkDescription.LegendNetCasting = "A well equipped mercenary is a prepared mercenary..."
+ "\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]"
+ "\n• Increase the max amount of stored nets by 1."
+ "\n• Nets thrown by this brother are 20% harder to break out of.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendNetCasting].Name = ::Const.Strings.PerkName.LegendNetCasting;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendNetCasting].Tooltip = ::Const.Strings.PerkDescription.LegendNetCasting;

::mods_hookExactClass("skills/perks/perk_legend_net_casting", function (o)
{
	o.onUpdate = function( _properties ) { }
});

//======================================================================================================================
//remove net item drops from throwing nets
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
			breakFree.setChanceBonus(0);

			if (_user.getSkills().hasSkill("perk.legend_net_casting")) breakFree.setChanceBonus(-20);

			if (this.m.IsReinforced) breakFree.setDecal("net_destroyed_02");
			else breakFree.setDecal("net_destroyed");

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

//======================================================================================================================

//TODO: rework: Add code to dodge spider webs, melee defense - 10
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

//======================================================================================================================

//TODO: rework: Add code to dodge roots, over ptr code
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