package controllers
import (
    "github.com/astaxie/beego"
)

type HomePage struct { beego.Controller }

func (c *HomePage) Get() {
    c.TplNames = "homepage.tpl"
    c.Render()
}
