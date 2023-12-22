::Const.Strings.PerkName.SpecBow = "Ranged Proficiency";
::Const.Strings.PerkDescription.SpecBow = ::MSU.Text.color(::Z.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("1") + " Vision"
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Ranged)"
+ "\n " + ::MSU.Text.colorGreen("– 3") + " AP cost for reloading"
+ "\n " + ::MSU.Text.colorRed("Can scavage 1-3 bolts or arrows from corpses");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecBow].Name = ::Const.Strings.PerkName.SpecBow;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecBow].Tooltip = ::Const.Strings.PerkDescription.SpecBow;

this.perk_mastery_bow <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.bow";
		this.m.Name = ::Const.Strings.PerkName.SpecBow;
		this.m.Description = ::Const.Strings.PerkDescription.SpecBow;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Ranged"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Ranged"));
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && (weapon.isWeaponType(::Const.Items.WeaponType.Bow) || weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
	}

	
	function restoreAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Ammo);
		if (item == null) return;
		if (!this.getContainer().getActor().isPlayerControlled()) return;
		local amount = ::Math.rand(1,3);
		item.m.Ammo += amount
		return amount;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.IsSpecializedInBows = true;

		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !this.isEnabled() || !::Tactical.TurnSequenceBar.isActiveEntity(actor)) return;

		
		if (!actor.isPlayerControlled()) return;
		if (actor.m.IsMoving)
		{
			local tile = actor.getTile();
			if (tile == null || !this.canProcOntile(tile)) return;
			this.spawnIcon("hybridization", tile);
			::Const.Combat.OpportunistUsedTiles.push(tile.ID);
			::Tactical.EventLog.log(
				::Const.UI.getColorizedEntityName(actor) + " recovered " + restoreAmmo() + " ammo"
			);
		}
	}

	function canProcOntile( _tile )
	{
		return _tile.IsCorpseSpawned && ::Const.Combat.OpportunistUsedTiles.find(_tile.ID) == null;
	}

	function onCombatStarted()
	{
		::Const.Combat.OpportunistUsedTiles.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		::Const.Combat.OpportunistUsedTiles.clear();
	}

});

