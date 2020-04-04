import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhf
 * @classname MBG
 * @description TODO
 * @date 2019/12/17
 **/
public class MBG {
    public static void main(String[] args) throws Exception {
        String fileName = "C:\\Users\\yhf\\IdeaProjects\\bookstore\\src\\main\\resources\\generatorConfig.xml";
        File configFile = new File(fileName);
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }
}
