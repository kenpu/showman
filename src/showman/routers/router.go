package routers

import (
	"go4it/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/test/", &controllers.Test{})
    beego.Router("/data/", &controllers.TestData{})
    beego.Router("/content/*", &controllers.Content{})
    beego.Router("/", &controllers.MainController{})
}
