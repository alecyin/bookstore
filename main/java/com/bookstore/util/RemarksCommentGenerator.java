package com.bookstore.util;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.JavaElement;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.api.dom.xml.XmlElement;
import org.mybatis.generator.internal.DefaultCommentGenerator;
import org.mybatis.generator.internal.util.StringUtility;

import java.util.Date;

public class RemarksCommentGenerator extends DefaultCommentGenerator {

    @Override
    public void addModelClassComment(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
    }

    public void addFieldComment(Field field, IntrospectedTable introspectedTable, IntrospectedColumn introspectedColumn) {
    }

    public void addFieldComment(Field field, IntrospectedTable introspectedTable) {
    }

    public void addGetterComment(Method method, IntrospectedTable introspectedTable, IntrospectedColumn introspectedColumn) {
//        method.addJavaDocLine("/**");
//        addJavadocTag(method, false);
//        method.addJavaDocLine(" */");
    }

    public void addSetterComment(Method method, IntrospectedTable introspectedTable, IntrospectedColumn introspectedColumn) {
//        method.addJavaDocLine("/**");
//        addJavadocTag(method, false);
//        method.addJavaDocLine(" */");
    }

    protected void addJavadocTag(JavaElement javaElement, boolean markAsDoNotDelete) {
//        StringBuilder sb = new StringBuilder();
//        sb.append(" * ");
//        sb.append(MergeConstants.NEW_ELEMENT_TAG);
//        if (markAsDoNotDelete) {
//            sb.append(" do_not_delete_during_merge"); //$NON-NLS-1$
//        }
//        String s = getDateString();
//        if (s != null) {
//            sb.append(' ');
//            sb.append(s);
//        }
//        javaElement.addJavaDocLine(sb.toString());
    }

    protected String getDateString() {
        return DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
    }

    public void addComment(XmlElement xmlElement) {
    }

    public void addGeneralMethodComment(Method method, IntrospectedTable introspectedTable) {
    }
}