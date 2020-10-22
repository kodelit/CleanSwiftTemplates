#!/usr/bin/swift
// This code is distributed under the terms and conditions of the MIT License:

// Copyright © 2020 kodelit.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

let scriptPath = CommandLine.arguments.first!
var dirUrl = URL(string: scriptPath)!
dirUrl.deleteLastPathComponent()
//var shouldGenDetail = CommandLine.arguments.contains(Param.genDetails)
//var shouldResetFileNames = CommandLine.arguments.contains(Param.resetFileNames)
let sourceDir = dirUrl.appendingPathComponent("Source")
let generatedTemplatesDir = dirUrl.appendingPathComponent("Output")
let fileManager = FileManager.default

if fileManager.fileExists(atPath: generatedTemplatesDir.absoluteString) {
    try fileManager.removeItem(at: generatedTemplatesDir)
}

var fileName = ""
var fileNameWithoutExtension = ""

let commentFileUrl = sourceDir.appendingPathComponent("SOURCE_FILE_TOP_COMMENT.swift")
let sourceFileTopComment = try String(contentsOf: commentFileUrl, encoding: .utf8)

let commonTemplatesDirNames = ["Assembler.xctemplate", "Interactor.xctemplate", "Models.xctemplate", "Presenter.xctemplate", "Router.xctemplate", "Worker.xctemplate"]
let viewControllerNames = ["UICollectionViewController", "UITableViewController", "UIViewController"]

let sceneTemplateDirName = "Scene.xctemplate"
let sceneTemplateSourceDir = sourceDir.appendingPathComponent(sceneTemplateDirName)
let viewControllerTemplateDirName = "View Controller.xctemplate"
let viewControllerSourceDir = sourceDir.appendingPathComponent(viewControllerTemplateDirName)
let viewControllerSourceFile = viewControllerSourceDir
    .appendingPathComponent("UIViewController")
    .appendingPathComponent("___FILEBASENAME___ViewController.swift")
let testsTemplatesDirName = "Unit Tests.xctemplate"

func getFileName(from url: URL) -> (fileName: String, fileNameWithoutExtension: String) {
    let fileName = url.lastPathComponent
    let fileNameWithoutExtension = url.deletingPathExtension().lastPathComponent
    return (fileName: fileName, fileNameWithoutExtension: fileNameWithoutExtension)
}

func generate(sourceFile: URL, targetDir: URL) throws {
    let (fileName, _) = getFileName(from: sourceFile)
    let targetFile = targetDir.appendingPathComponent(fileName)
    var content = try String(contentsOf: sourceFile, encoding: .utf8)
    content = sourceFileTopComment + content
    try content.write(to: targetFile, atomically: true, encoding: .utf8)
}

func generateCommonTemplates(installDir: URL, generateOnlySourceFile: Bool) throws {
    try fileManager.createDirectory(at: installDir, withIntermediateDirectories: true, attributes: nil)
    try commonTemplatesDirNames.forEach { (templateDirName) in
        let templateSourceDir = sourceDir.appendingPathComponent(templateDirName)
        var templateTargetDir = installDir

        if !generateOnlySourceFile {
            templateTargetDir.appendPathComponent(templateDirName)

            if fileManager.fileExists(atPath: templateTargetDir.absoluteString) {
                try fileManager.removeItem(at: templateTargetDir)
            }
            try fileManager.createDirectory(at: templateTargetDir, withIntermediateDirectories: true, attributes: nil)
            try fileManager.copyItem(at: sourceDir, to: installDir)
        }

        if let files = try? FileManager.default.contentsOfDirectory(atPath: sourceDir.absoluteString) {
            let swiftFiles = files.filter { $0.hasSuffix(".swift") }

            try swiftFiles.forEach { (path) in
                guard let url = URL(string: path) else { return }
                try generate(sourceFile: url, targetDir: templateTargetDir)
            }
        }
    }
}

try generateCommonTemplates(installDir: generatedTemplatesDir, generateOnlySourceFile: false)
