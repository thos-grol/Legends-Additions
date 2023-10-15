::Z <- {};
::Z.Economy <- {};
::Z.Backgrounds <- {};
::Z.Log <- {};
::Z.Perks <- {};

::B <- {}; //B for builds

::Z.Log.Color <- {};
::Z.Log.Color.BloodRed <- "#900C3F";
::Z.Log.Color.NiceGreen <- "#229954";
::Z.Log.Color.Blue <- "#21618C";
::Z.Log.Color.LightBlue <- "#3498DB";
::Z.Log.Color.Orange <- "#BA4A00";
::Z.Log.Color.Purple <- "#8E44AD";
::Z.Log.Color.Teal <- "#1ABC9C";
::Z.Log.Color.Gold <- "#F1C40F";
::Z.Log.Color.Pink <- "#dfabcd";
::Z.Log.HasActed <- false;

::Const.AI.Behavior.ID.FollowUp <- ::Const.AI.Behavior.ID.COUNT++;
::Const.AI.Behavior.Name.push("FollowUp");
::Const.AI.Behavior.Order.FollowUp <- this.Const.AI.Behavior.Order.AttackDefault;
::Const.AI.Behavior.Score.FollowUp <- 1;