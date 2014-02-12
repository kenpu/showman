package controllers

import (
	"github.com/astaxie/beego"
    "path/filepath"
    "os"
)

var RepositoryDir string

type MainController struct {
	beego.Controller
}

func (this *MainController) Get() {
	this.Data["Website"] = "beego.me"
	this.Data["Email"] = "astaxie@gmail.com"
	this.TplNames = "index.tpl"
    this.Data["Title"] = "Go 4 It"
}

type Test struct {
    beego.Controller
}

func (c *Test) Get() {
    c.TplNames = "test.tpl"
    c.Render()
}

type TestData struct {
    beego.Controller
}
func (c *TestData) Get() {
    data := struct {
        Name string
        Age  int
    }{"Hello", 13}
    c.Data["json"] = data
    c.ServeJson()
}


// Traverses through the directory, and lists the files 
// in the root directory.
func listFiles(root string) ([]string, error) {
    var paths = make([]string, 0)
    var walker filepath.WalkFunc = func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        } else {
            if ! info.IsDir() {
                path, _ = filepath.Rel(root, path)
                paths = append(paths, path)
            }
        }
        return nil
    }
    err := filepath.Walk(root, walker)

    return paths, err
}