;;; tree-sitter-utils.el --- Tree sitter utility functions  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Jeetaditya Chatterjee

;; Author: Jeetaditya Chatterjee <jeetelongname@gmail.com>
;; Keywords: languages, convenience, lisp,
;;; Commentary:
;; These are functions act as an an abstraction over tree sitter to make writing things for it easier
;; they add a bunch of utility commands that are too small for there own package
;;; Code:

(require 'tree-sitter)

(defgroup tree-sitter-utils nil
  "Tree sitter utility functions."
  :group 'tree-sitter)

(defcustom tree-sitter-utils-function-querys-alist '((ruby-mode ."[(method) (singleton_method)] @function"))
  "A set of modes and associated querys that match too all functions in a buffer."
  :group 'tree-sitter-utils
  :type '(alist
          :key-type symbol
          :value-type string))


(defun tree-sitter-utils-count-querys (query)
  "Return the number of matched querys in a buffer.
Takes a QUERY :: String as an argument.
Returns a number"
  (require 'tsc)
  (let* ((root-node (tsc-root-node tree-sitter-tree))
         (query (tsc-make-query tree-sitter-language query))
         (captures (tsc-query-captures query root-node #'tsc--buffer-substring-no-properties)))
    (length captures)))

(defun tree-sitter-utils-count-functions ()
  "Count all the functions in a buffer."
  (interactive)
  (message "there are %s functions in this buffer"
           (tree-sitter-utils-count-querys
             (alist-get major-mode tree-sitter-utils-function-querys-alist))))

(provide 'tree-sitter-utils)
;;; tree-sitter-utils.el ends here
