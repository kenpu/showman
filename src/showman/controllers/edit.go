package controllers

import (
    "github.com/astaxie/beego"
)

type Edit struct { beego.Controller }

func (c *Edit) Get() {
    var filename = c.Ctx.Input.Param(":splat")
    c.TplNames = "edit.tpl"
    c.Data["filename"] = filename
    c.Render()
}
