this.getroottable().gameplay_improved.hook_backgrounds <- function ()
{
	::mods_hookExactClass("entity/tactical/player", function (o)
	{
		local setStartValuesEx = ::mods_getMember(o, "setStartValuesEx");
		o.setStartValuesEx = function(_backgrounds, _addTraits = true, _gender = -1, _addEquipment = true)
		{
			setStartValuesEx(_backgrounds, _addTraits, _gender, _addEquipment);
			switch(this.getBackground().getID())
			{
				case "background.assassin":
				case "background.assassin_southern":
				case "background.raider":
				case "background.nomad":
				case "background.legend_ranger":
				case "background.poacher":
				case "background.hunter":
					this.getSkills().add(this.new("scripts/skills/traits/tracker_trait"));
					break;
				case "background.minstrel":
				case "background.female_minstrel":
				case "background.legend_qiyan":
					this.getSkills().add(this.new("scripts/skills/traits/entertainer_trait"));
					break;
				case "background.anatomist":
					this.getSkills().add(this.new("scripts/skills/traits/bloodline_researcher_trait"));
					break;

			}
		}
	});
	
	local str_detection = "\n\nKnowledgeable in ways to escape detection of the authorities when doing criminal acts. ie. Decreases chance of relationship hit on attacking parties. Base: 60, -10. Cannot be reduced below 5.";
	local str_detection2 = "\n\nCan spread rumors to distract attention away from your party. ie. Decreases chance of relationship hit on attacking parties. Base: 60, -15. Cannot be reduced below 5.";

};