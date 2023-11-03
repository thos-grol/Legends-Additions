::mods_hookExactClass("skills/special/mood_check", function (o)
{
    o.m.Stacks <- 0;
	o.m.MaxStacks <- 10;

    o.create = function()
	{
		this.m.ID = "special.mood_check";
		this.m.Name = "Details";
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.IconMini = "";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.Trait;
		this.m.Order = ::Const.SkillOrder.Background + 5;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
	}

    o.getDescription <- function()
	{
		return "Provides details about the character's progression and armor.";
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();
		local details = getTooltip_Details();
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();


		getTooltip_Proficiency(tooltip);

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Skill Fatigue Mult: " + ::MSU.Text.colorGreen(p.FatigueEffectMult)
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Fatality Chance Mult: " + ::MSU.Text.colorGreen(p.FatalityChanceMult)
		});

        tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Armor class: " + details.Name + " (" + ::MSU.Text.colorGreen(details.Weight) + ") [" + details.Range + "]"

		});

		switch(details.Type)
		{
			case 1: //Light
			getTooltip_FreedomOfMovement(tooltip);
			break;

			case 2: //Medium
			getTooltip_MediumArmor(tooltip);
			break;

			case 3: //Heavy
			getTooltip_ManOfSteel(tooltip);
			break;
		}

		if (this.getContainer().hasSkill("perk.nimble")) getTooltip_Nimble(tooltip);
		if (this.getContainer().hasSkill("perk.legend_lithe")) getTooltip_Lithe(tooltip);
		if (this.getContainer().hasSkill("perk.battle_forged")) getTooltip_Battleforged(tooltip);

		if (this.getContainer().hasSkill("perk.legend_small_target")) getTooltip_SmallTarget(tooltip);
		if (this.getContainer().hasSkill("effects.dodge")) getTooltip_Dodge(tooltip);

		return tooltip;
	}

	// =============================================================================================
	// Proficiency tooltips
	// =============================================================================================

	o.getTooltip_Proficiency <- function( _tooltip )
	{
		local actor = this.getContainer().getActor();
		local skill;
		local count = 0;

		local proficiencies = [
			"trait.proficiency_Axe",
			"trait.proficiency_Cleaver",
			"trait.proficiency_Sword",
			"trait.proficiency_Mace",
			"trait.proficiency_Hammer",
			"trait.proficiency_Flail",
			"trait.proficiency_Spear",
			"trait.proficiency_Polearm",
			"trait.proficiency_Unarmed",
			"trait.proficiency_Ranged",
		];

		foreach (proficiency in proficiencies)
		{
			skill = actor.getSkills().getSkillByID(proficiency);
			if (skill != null)
			{
				skill.getDetails(_tooltip);
				count += 1;
			}
		}

		if (count > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "========================"
			});
		}

		return _tooltip;
	}


	// =============================================================================================
	// Logic
	// =============================================================================================

	o.onUpdate = function( _properties )
	{
	}

    o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		local total_weight = getTotalWeight();
        if (total_weight <= 20) // Freedom of Movement
        {
            if (_attacker == null) return;
            if (_skill == null) return;

			if (!_skill.isAttack() || _skill.isRanged() || !_skill.isUsingHitchance()) return;
			if (_attacker.getID() == this.getContainer().getActor().getID()) return;

			local slam = _attacker.getSkills().getSkillByID("perk.stance.seismic_slam");
			if (slam != null) return;
			
            local ourCurrentInitiative = this.getContainer().getActor().getInitiative();
            local enemyCurrentInitiative = _attacker.getInitiative();
            local bonus = 1;
            if (ourCurrentInitiative > enemyCurrentInitiative)
            {
                local diff = (ourCurrentInitiative - enemyCurrentInitiative) / 100.0;
                local diffPoint = this.Math.minf(1, this.Math.pow(diff, 0.4)) * 0.8;
                bonus = 1 - diffPoint;
            }
			_properties.DamageReceivedRegularMult *= bonus;

			bonus = 1 - bonus;
			if (bonus > 0) ::Tactical.EventLog.logIn(
				"[Freedom of Movement] -" + (::Z.Log.roundFloat(bonus, 2) * 100) + "% damage"
			);
        }
        else if (total_weight > 20 && total_weight <= 40) // Medium Armor
        {
            if (_attacker != null && _skill != null && _skill.isAttack())
			{
				local bonus = this.m.Stacks * 0.05;
				_properties.DamageReceivedRegularMult *= 1 - bonus;
				this.m.Stacks = ::Math.max(0, this.m.Stacks - 2);
				if (bonus > 0) ::Tactical.EventLog.logIn(
					"[Medium Armor Passive] -" + (::Z.Log.roundFloat(bonus, 2) * 100) + "% damage"
				);
			}
        }
		else //Man of steel
		{
			if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) return;
			local bonus = this.getBonus_ManOfSteel(_hitInfo.BodyPart) * 0.01;
			_properties.DamageReceivedDirectMult *= 1.0 - bonus;
			if (bonus > 0) ::Tactical.EventLog.logIn(
				"[Man of Steel] -" + (::Z.Log.roundFloat(bonus, 2)  * 100) + "% hitpoint damage"
			);
		}
	}

    o.getTotalWeight <- function()
    {
        return this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;
    }

// =============================================================================================
// Medium Armor
// =============================================================================================

    o.onAfterUpdate <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap()) this.m.Stacks = 5; //Start off with 25% dr

	}

	o.onMissed <- function( _attacker, _skill )
	{
		local total_weight = getTotalWeight();
		if (total_weight > 20 && total_weight <= 40)
        {
            if (_attacker != null && _skill != null && _skill.isAttack() && !_skill.isRanged()) this.m.Stacks = this.Math.min(this.m.MaxStacks, this.m.Stacks + 1);
        }

	}

// =============================================================================================
// Helper Fns
// =============================================================================================

	o.getTooltip_Details <- function(  )
	{
		local ret = {
			Weight = getTotalWeight()
		};

		if (ret.Weight <= 20)
		{
			ret.Name <- "Light";
			ret.Type <- 1;
			ret.Range <- "0 - 20";
		}
        else if (ret.Weight <= 40)
		{
			ret.Name <- "Medium";
			ret.Type <- 2;
			ret.Range <- "21 - 40";
		}
        else
		{
			ret.Name <- "Heavy";
			ret.Type <- 3;
			ret.Range <- "40+";
		}

		return ret;
	}

// =============================================================================================
// Modular Tooltips: Light
// =============================================================================================

    o.getTooltip_FreedomOfMovement <- function( _tooltip )
	{
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::MSU.Text.colorGreen("– x%") + " damage taken proportional to the initiative difference between the attacker and this unit for melee attacks. (Max 80% for a 100 difference)."
		});
		return _tooltip;
	}

	o.getTooltip_Nimble <- function( _tooltip )
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Head);
		if (body != null) fat = fat + body.getStaminaModifier();
		if (head != null) fat = fat + head.getStaminaModifier();
		fat = this.Math.min(0, fat + 15);
		local ret = this.Math.minf(1.0, 1.0 - 0.6 + this.Math.pow(this.Math.abs(fat), 1.23) * 0.01);
		local fm = this.Math.floor(ret * 100);

		if (fm < 100)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Nimble: " + ::MSU.Text.colorGreen("– " + fm + "%") + " hitpoint damage taken"
			});
		}

		return _tooltip;
	}

	o.getTooltip_Dodge <- function( _tooltip )
	{
		local initiative = this.Math.max(0, this.Math.floor(this.getContainer().getActor().getInitiative() * 0.15));
		if (initiative == 0) return _tooltip;
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "Dodge: " + ::MSU.Text.colorGreen("+" + initiative) + " Melee and Ranged Defense"
		});
		return _tooltip;
	}

	o.getTooltip_SmallTarget <- function( _tooltip )
	{
		local bonus = SmallTarget_getBonus();

		if (bonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Small Target: [color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			});
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Small Target: [color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			});
		}

		local bonus2 = SmallTarget_getBonus2();

		if (bonus2 > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Small Target: [color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus2 + "%[/color] chance for enemies to be forced to reroll their attack"
			});
		}

		return _tooltip;
	}

	o.SmallTarget_getBonus <- function ()
	{
		local stackTotal = 0;
		local actor = this.getContainer().getActor();
		local health = 0;
		health = actor.getBaseProperties().Hitpoints;
		local bodyItem = actor.getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local bodyArmor = 0;
		local headItem = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
		local headArmor = 0;

		if (bodyItem != null)
		{
			bodyArmor = actor.getArmor(::Const.BodyPart.Body);
		}

		if (headItem != null)
		{
			headArmor = actor.getArmor(::Const.BodyPart.Head);
		}

		local stackTotal = health + headArmor + bodyArmor;

		if (bodyItem != null)
		{
			local tabard = bodyItem.getUpgrade(::Const.Items.ArmorUpgrades.Tabbard);
			local cloak = bodyItem.getUpgrade(::Const.Items.ArmorUpgrades.Cloak);

			if (tabard != null)
			{
				local tabardArmor = tabard.getRepair();
				stackTotal = stackTotal - tabardArmor;
			}

			if (cloak != null)
			{
				local cloakArmor = cloak.getRepair();
				stackTotal = stackTotal - cloakArmor;
			}
		}

		if (headItem != null)
		{
			local vanity = headItem.getUpgrade(::Const.Items.HelmetUpgrades.Vanity);
			local extra = headItem.getUpgrade(::Const.Items.HelmetUpgrades.ExtraVanity);

			if (vanity != null)
			{
				local vanityArmor = vanity.getRepair();
				stackTotal = stackTotal - vanityArmor;
			}

			if (extra != null)
			{
				local extraArmor = extra.getRepair();
				stackTotal = stackTotal - extraArmor;
			}
		}

		local bonus = this.Math.max(5, 100 - stackTotal);
		return this.Math.floor(bonus);
	}

	o.SmallTarget_getBonus2 <- function()
	{
		local actor = this.getContainer().getActor();
		local mdef = actor.getCurrentProperties().getMeleeDefense();
		local resolve = actor.getCurrentProperties().getBravery();
		local stack = mdef + resolve;
		local bonus = this.Math.max(10, 100 - stack);
		return this.Math.floor(bonus);
	}

// =============================================================================================
// Modular Tooltips: Medium
// =============================================================================================

	o.getTooltip_MediumArmor <- function( _tooltip)
	{
		local bonus = this.m.Stacks * 5;

        _tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/health.png",
            text = ::MSU.Text.colorGreen("– " + bonus + "%") + " damage taken. " + ::MSU.Text.colorGreen("+5%") + " upon dodging. " + ::MSU.Text.colorGreen("– 10%") + " when hit. " + ::MSU.Text.colorRed("(50% Max)")
        });

		return _tooltip;
	}

	o.Lithe_getArmorFatPenMult <- function ( _totalArmorStaminaModifier )
	{
		_totalArmorStaminaModifier = _totalArmorStaminaModifier * -1;
		local steepnessFactor = 2.5999999;
		local armorIdealMin = 25;
		local armorIdealMax = 35;
		local mult = 1;

		if (_totalArmorStaminaModifier < armorIdealMin)
		{
			mult = this.Math.maxf(0, 1 - 0.01 * this.Math.pow(armorIdealMin - _totalArmorStaminaModifier, steepnessFactor));
		}
		else if (_totalArmorStaminaModifier > armorIdealMax)
		{
			mult = this.Math.maxf(0, 1 - 0.01 * this.Math.pow(_totalArmorStaminaModifier - armorIdealMax, steepnessFactor));
		}

		return mult;
	}

	o.Lithe_getBonus <- function()
	{
		local actor = this.getContainer().getActor();
		local bodyitem = actor.getBodyItem();

		if (bodyitem == null) return 0;

		local armorFatMult = Lithe_getArmorFatPenMult(actor.getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head
		]));

		local bonus = this.Math.maxf(0, this.Math.minf(35, 35 * armorFatMult));
		return this.Math.floor(bonus);
	}

	o.getTooltip_Lithe <- function( _tooltip)
	{
		local bonus = Lithe_getBonus();
		if (bonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Lithe: " + ::MSU.Text.colorGreen("– " + (100 - bonus) + "%") + " damage taken"
			});
			return _tooltip;
		}

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Lithe: No damage reduction because this unit is not wearing any body armor."
			});
			return tooltip;
		}

		return _tooltip;
	}

// =============================================================================================
// Modular Tooltips: Heavy
// =============================================================================================

	o.getBonus_ManOfSteel <- function( _bodyPart )
	{
		return ::Math.min(100, this.getContainer().getActor().getArmor(_bodyPart) * 0.1);
	}

	o.getTooltip_ManOfSteel <- function( _tooltip)
	{
		local headBonus = this.getBonus_ManOfSteel(::Const.BodyPart.Head);
		local bodyBonus = this.getBonus_ManOfSteel(::Const.BodyPart.Body);
		if (headBonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::MSU.Text.colorGreen("– " + headBonus + "%") + " hitpoint damage taken " + ::MSU.Text.colorRed("(Head)")
			});
		}
		if (bodyBonus > 0)
		{
			_tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::MSU.Text.colorGreen("– " + bodyBonus + "%") + " hitpoint damage taken " + ::MSU.Text.colorRed("(Body)")
			});
		}

		return _tooltip;
	}

	o.getTooltip_Battleforged <- function( _tooltip)
	{
		local armor = this.getContainer().getActor().getArmor(::Const.BodyPart.Head) + this.getContainer().getActor().getArmor(::Const.BodyPart.Body);
		local reduction = this.Math.floor(armor * 5 * 0.01);

		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/armor_head.png",
			text = "Battleforged: " + ::MSU.Text.colorGreen("– " + reduction + "%") + " armor damage taken"
		});

		return _tooltip;
	}

// =============================================================================================
// Keep old mood code
// =============================================================================================
    o.onCombatStarted = function()
	{
		local actor = this.getContainer().getActor();
        if (!this.getContainer().getActor().isPlayerControlled()) return;

		local mood = actor.getMoodState();
		local morale = actor.getMoraleState();
		local isDastard = this.getContainer().hasSkill("trait.dastard");

		switch(mood)
		{
            case ::Const.MoodState.Concerned:
                actor.setMaxMoraleState(::Const.MoraleState.Steady);
                actor.setMoraleState(::Const.MoraleState.Steady);
                break;

            case ::Const.MoodState.Disgruntled:
                actor.setMaxMoraleState(::Const.MoraleState.Wavering);
                actor.setMoraleState(::Const.MoraleState.Wavering);
                break;

            case ::Const.MoodState.Angry:
                actor.setMaxMoraleState(::Const.MoraleState.Breaking);
                actor.setMoraleState(::Const.MoraleState.Breaking);
                break;

            case ::Const.MoodState.Neutral:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                break;
            case ::Const.MoodState.InGoodSpirit:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                if (morale < ::Const.MoraleState.Confident && this.Math.rand(1, 100) <= 25 && !isDastard)
                    actor.setMoraleState(::Const.MoraleState.Confident);
                break;
            case ::Const.MoodState.Eager:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                if (morale < ::Const.MoraleState.Confident && this.Math.rand(1, 100) <= 50 && !isDastard)
                    actor.setMoraleState(::Const.MoraleState.Confident);
                break;
            case ::Const.MoodState.Euphoric:
                actor.setMaxMoraleState(::Const.MoraleState.Confident);
                if (morale < ::Const.MoraleState.Confident && this.Math.rand(1, 100) <= 75 && !isDastard)
                    actor.setMoraleState(::Const.MoraleState.Confident);
                break;
        }
	}


});