::Const.Strings.PerkName.MeditationOmenOfDecay <- "Omen of Decay";
::Const.Strings.PerkDescription.MeditationOmenOfDecay <- ::MSU.Text.color(::Z.Color.Purple, "Meditation")
+ "\nAll that is will decay and return to dust..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\nBecome immune to decay"
+ "\n"+::MSU.Text.colorGreen("+X") + " decay damage (affects Miasma Body)"
+ "\n"+::MSU.Text.colorGreen("+2X") + " fatigue damage from Mark of Decay"
+ "\n"+::MSU.Text.colorGreen("+2X%") + " chance of rotten offering reanimating a corpse"
+ "\n"+::MSU.Text.colorRed("X is the potency of omen of decay")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Unit dies having decay effect, 10%:")
+ "\n"+::MSU.Text.colorGreen("+1") + " potency (Max: 10)"
+ "\n\n"+::MSU.Text.colorRed("Unlocks winter potion recipe, but an alchemist and anatomist is needed");


::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.MeditationOmenOfDecay].Name = ::Const.Strings.PerkName.MeditationOmenOfDecay;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.MeditationOmenOfDecay].Tooltip = ::Const.Strings.PerkDescription.MeditationOmenOfDecay;

this.perk_meditation_omen_of_decay <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.meditation.omen_of_decay";
		this.m.Name = ::Const.Strings.PerkName.MeditationOmenOfDecay;
		this.m.Description = ::Const.Strings.PerkDescription.MeditationOmenOfDecay;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.NoRefund <- true;
	}

	function onAdded()
	{
		this.World.Statistics.getFlags().set("potion_winter", true);
		local actor = this.getContainer().getActor();
		if (actor.getFaction() == ::Const.Faction.Player) return;
		if (!actor.getFlags().has("decay_bonus")) actor.getFlags().set("decay_bonus", 5);

		if (!actor.getFlags().has("undead")) return;
		local miasma = ::new("scripts/skills/special/_miasma_body");
		miasma.setActor(actor);
		actor.getSkills().add(miasma);
	}


});

