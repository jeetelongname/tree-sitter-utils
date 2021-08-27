;;; tree-sitter-utils.el --- Tree sitter utility functions  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Jeetaditya Chatterjee

;; Author: Jeetaditya Chatterjee <jeetelongname@gmail.com>
;; Keywords: languages, convenience, lisp,
;;; Commentary:
;; These are functions act as an an abstraction over tree sitter to make writing things for it easier
;; they add a bunch of utility commands that are too small for there own package
;;; Code:

(require 'tree-sitter)

(defvar tree-sitter-utils-function-querys-alist '(('ruby-mode . "[(method) (singleton_method)] @function"))
  "A set of modes and associated querys that match too all functions in a buffer.")

(defun tree-sitter-utils-count-functions ()
  "Count all functions in a buffer."
  (interactive)
  (require 'tsc)
  (let* ((debugging-query (cdr (assoc major-mode tree-sitter-utils-function-querys-alist)))
         (root-node (tsc-root-node tree-sitter-tree))
         (query (tsc-make-query tree-sitter-language debugging-query))
         (captures (tsc-query-captures query root-node #'tsc--buffer-substring-no-properties)))
    (message "%s" (length captures))))

(provide 'tree-sitter-utils)
;;; tree-sitter-utils.el ends here
