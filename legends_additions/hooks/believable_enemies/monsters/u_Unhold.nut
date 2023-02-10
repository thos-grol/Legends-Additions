::Const.Tactical.Actor.Unhold <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/unhold", function (o)
{
    o.onInit = function()
    {
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Unhold);
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRotation = true;

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_unhold_body_02";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");

		if (this.Math.rand(1, 100) < 5)
		{
			body.setBrush("bust_unhold_body_04");
		}
		else
		{
			body.setBrush("bust_unhold_body_02");
		}

		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_02_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");

		if (this.Math.rand(1, 100) < 3)
		{
			head.setBrush("bust_unhold_head_04");
		}
		else
		{
			head.setBrush("bust_unhold_head_02");
		}

		head.Saturation = body.Saturation;
		head.Color = body.Color;

		foreach( a in ::Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		this.addSprite("accessory");
		this.addSprite("accessory_special");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));

        //actives
        this.m.Skills.add(::new("scripts/skills/actives/sweep_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/sweep_zoc_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/fling_back_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/unstoppable_charge_skill"));
        //TODO: remember to add potion perks to rock unholds

        //traits
        this.m.Skills.add(::new("scripts/skills/traits/fearless_trait"));
        this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
        this.m.Skills.add(::new("scripts/skills/effects/wiederganger_potion_effect"));
        this.m.Skills.add(::new("scripts/skills/racial/unhold_racial"));

        this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_stalwart"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_deep_impact"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_menacing"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));

        local dismantle = ::new("scripts/skills/perks/perk_ptr_dismantle");
		dismantle.m.IsForceEnabled = true;
		this.m.Skills.add(dismantle);
		local faPerk = ::new("scripts/skills/perks/perk_ptr_formidable_approach");
		faPerk.m.IsForceEnabled = true;
		this.m.Skills.add(faPerk);
        local dentArmorPerk = ::new("scripts/skills/perks/perk_ptr_dent_armor");
        dentArmorPerk.m.IsForceEnabled = true;
        dentArmorPerk.m.IsForceTwoHanded = true;
        this.m.Skills.add(dentArmorPerk);

		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battering_ram"));

        local returnFavor = ::new("scripts/skills/effects/return_favor_effect");
        returnFavor.onTurnStart = function() {}; // overwrite the original function which removes it
        this.m.Skills.add(returnFavor);
	}

});

//No more bullshit 100% hit chance grab
::mods_hookExactClass("skills/actives/fling_back_skill", function (o)
{
    o.onUse = function( _user, _targetTile )
	{
		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};

        local roll = this.Math.rand(1, 100);
        local hitChance = this.Math.max(5, this.Math.min(95, _user.getCurrentProperties().getMeleeSkill() - _targetTile.getEntity().getCurrentProperties().getMeleeDefense()));

        if (roll <= hitChance)
        {
            if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
            {
                if (this.m.SoundOnUse.len() != 0)
                {
                    this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
                }

                this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay, this.onPerformAttack.bindenv(this), tag);

                if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
                {
                    _user.getTile().addVisibilityForFaction(::Const.Faction.Player);
                }
            }
            else
            {
                this.onPerformAttack(tag);
            }
        }
        else
        {
            if (!_targetTile.getEntity().isHiddenToPlayer())
            {
                this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " dodges " + ::Const.UI.getColorizedEntityName(_user) + "'s grab, but gives away their position." + " (Chance: " + hitChance + ", Rolled: " + roll + ")");
            }

            local target = _targetTile.getEntity();

            if (this.m.SoundOnUse.len() != 0)
            {
                this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
            }

            local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

            if (knockToTile == null)
            {
                return false;
            }

            this.applyFatigueDamage(target, 10);

            if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
            {
                return false;
            }

            local skills = target.getSkills();
            skills.removeByID("effects.shieldwall");
            skills.removeByID("effects.spearwall");
            skills.removeByID("effects.riposte");

            if (this.m.SoundOnHit.len() != 0)
            {
                this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
            }

            target.setCurrentMovementType(::Const.Tactical.MovementType.Involuntary);
            local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * ::Const.Combat.FallingDamage;

            if (damage == 0)
            {
                this.Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
            }
            else
            {
                local p = this.getContainer().getActor().getCurrentProperties();
                local tag = {
                    Attacker = _user,
                    Skill = this,
                    HitInfo = clone ::Const.Tactical.HitInfo
                };
                tag.HitInfo.DamageRegular = damage;
                tag.HitInfo.DamageFatigue = ::Const.Combat.FatigueReceivedPerHit;
                tag.HitInfo.DamageDirect = 1.0;
                tag.HitInfo.BodyPart = ::Const.BodyPart.Body;
                tag.HitInfo.BodyDamageMult = 1.0;
                tag.HitInfo.FatalityChanceMult = 1.0;
                this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true);
            }

            local tag = {
                TargetTile = _targetTile,
                Actor = _user
            };
            this.Time.scheduleEvent(this.TimeUnit.Virtual, 250, this.onFollow, tag);
        }

		return true;
	}
});