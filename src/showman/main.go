package main

import (
	"github.com/astaxie/beego"
    C "showman/controllers"
    "os"
)

func main() {
    C.RepositoryDir = os.Getenv("RepositoryDir")
    if C.RepositoryDir == "" {
        C.RepositoryDir = "."
    }

    // Angular widgets
    beego.SetStaticPath("/partials", "partials")

    // Views
    beego.Router("/", &C.HomePage{})
    beego.Router("/index/", &C.Repo{})
    beego.Router("/edit/*",  &C.Edit{})
    beego.Router("/editor", &C.Edit{}, "get:Editor")
    beego.Router("/view/*",  &C.View{})

    // API
    beego.Router("/api/file/*", &C.File{})

    beego.Router("/test/",   &C.Test{})
    beego.Router("/data/",   &C.TestData{})

	beego.Run()
}

