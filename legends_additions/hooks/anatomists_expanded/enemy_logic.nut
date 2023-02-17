//add potion code to actor class
::mods_hookExactClass("entity/tactical/actor", function (o)
{
    o.add_potion <- function(name, complete)
    {
        switch(name)
        {
            case "direwolf":
                this.getFlags().add("werewolf");

                this.m.Skills.add(::new("scripts/skills/effects/direwolf_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_menacing"));

                if (complete)
                {
                    this.getFlags().add("werewolf_8");
                    this.m.Skills.removeByID("perk.underdog");
                    this.m.Skills.add(::new("scripts/skills/perks/perk_legend_battleheart"));
                    this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_unstoppable"));
                }
                break;
            case "ghoul":
                this.getFlags().add("ghoul");
                this.m.Skills.add(::new("scripts/skills/effects/hyena_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_gruesome_feast"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));

                if (complete)
                {
                    this.getFlags().add("ghoul_8");
                    this.m.Skills.add(::new("scripts/skills/effects/unhold_potion_effect"));
                    this.m.Skills.add(::new("scripts/skills/effects/ancient_priest_potion_effect"));
                    this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lacerate"));
                }
                break;
            case "spider":
                this.getFlags().add("spider");
                this.m.Skills.add(::new("scripts/skills/effects/webknecht_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_item_web_skill"));
                this.m.Skills.add(::new("scripts/skills/effects/serpent_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));

                if (complete)
                {
                    this.getFlags().add("spider_8");
                    this.m.Skills.add(::new("scripts/skills/perks/perk_legend_escape_artist"));
                    this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
                }
                break;
            case "unhold":
                this.getFlags().add("unhold");
                this.m.Skills.add(::new("scripts/skills/traits/huge_trait"));

                this.m.Skills.add(::new("scripts/skills/effects/unhold_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/effects/wiederganger_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_muscularity"));

                if (complete)
                {
                    this.getFlags().add("unhold_8");
                    this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
                    this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
                }
                break;
            case "orc":
                this.getFlags().add("orc");
                this.m.Skills.add(::new("scripts/skills/traits/huge_trait"));
                this.m.Skills.add(::new("scripts/skills/traits/iron_jaw_trait"));
                this.m.Skills.add(::new("scripts/skills/effects/orc_young_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));

                if (complete)
                {
                    this.getFlags().add("orc_8");
                    this.m.Skills.add(::new("scripts/skills/effects/orc_warlord_potion_effect"));
                    this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
                }
                break;
            case "necrosavant":
                this.getFlags().add("vampire");
                this.m.Skills.add(::new("scripts/skills/effects/necrosavant_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_darkflight"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lacerate"));

                if (complete)
                {
                    this.getFlags().add("vampire_8");
                    this.m.Skills.add(::new("scripts/skills/effects/ancient_priest_potion_effect"));
                    this.m.Skills.add(::new("scripts/skills/effects/webknecht_potion_effect"));
                }

                local agent = this.actor.getAIAgent();
                if (agent.findBehavior(::Const.AI.Behavior.ID.Darkflight) == null)
                {
                    agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_darkflight"));
                    agent.finalizeBehaviors();
                }
                break;
            case "goblin":
                this.getFlags().add("goblin");
                this.m.Skills.add(::new("scripts/skills/traits/tiny_trait"));
                this.m.Skills.add(::new("scripts/skills/effects/goblin_overseer_potion_effect"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hair_splitter"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
                this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_eyes_up"));
                break;
            // case "serpent":
            //     this.getFlags().add("serpent");
            //     this.m.Skills.add(::new("scripts/skills/effects/serpent_potion_effect"));
            //     this.m.Skills.add(::new("scripts/skills/effects/webknecht_potion_effect"));
            //     this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pattern_recognition"));
            //     this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));
                break;
        }

    }

});

//////////////////////////////// AI ///////////////////////////////////////////
::mods_hookExactClass("ai/tactical/behaviors/ai_darkflight", function (o)
{
    o.m.PossibleSkills = [
        "actives.darkflight",
        "actives.legend_darkflight"
    ];
});