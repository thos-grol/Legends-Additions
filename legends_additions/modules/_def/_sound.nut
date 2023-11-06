::Z.Lib.play_start <- function ()
{
    this.Sound.play("sounds/ui/start.wav", this.Const.Sound.Volume.Inventory * 10);
}

::Z.Lib.play_click <- function ()
{
    this.Sound.play("sounds/ui/click.wav", this.Const.Sound.Volume.Inventory * 10);
}
