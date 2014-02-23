package controllers

import (
    "github.com/astaxie/beego"
    "path"
)

type Edit struct { beego.Controller }

func (c *Edit) Get() {
    var filename = c.Ctx.Input.Param(":splat")
    c.TplNames = "edit.tpl"
    c.Data["Filename"] = filename
    c.Render()
}

func (c *Edit) Editor() {
    var spanName = c.Ctx.Input.Param(":splat")
    var filename = path.Dir(spanName)
    var spanId = path.Base(spanName)

    c.TplNames = "intercom-editor.tpl"
    c.Data["Filename"] = filename
    c.Data["SpanId"] = spanId
    c.Render()
}