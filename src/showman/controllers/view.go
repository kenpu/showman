package controllers

import (
    "github.com/astaxie/beego"
)

type View struct { beego.Controller }

func (c *View) Get() {
    c.TplNames = "404.tpl"
    c.Render()
}
