package controllers

import (
	"github.com/astaxie/beego"
    "path/filepath"
    "os"
    "io/ioutil"
)

var RepositoryDir string

type Controller struct {
    beego.Controller
}

func (this *Controller) ServeJsonFile(filename string) {
    content, err := ioutil.ReadFile(filename)
    if err != nil {
        this.Data["json"] = map[string]string {
            "error": err.Error(),
        }
    } else {
        this.Ctx.Output.Header("Content-Type", "application/json;charset=UTF-8")
        this.Ctx.Output.Body(content)
    }
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