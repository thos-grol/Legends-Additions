::mods_hookExactClass("ai/tactical/agents/hexe_agent", function(o) {
    o.onAddBehaviors = function()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_sleep"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charm"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_hex"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wither"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_use_potion"));
	}
});
