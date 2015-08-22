<?php

/** @return Config[] */
function getConfig()
{
    $repos = [];

    $repos[] = new Config('git@github.com:skaut/Skautis.git', 'Skautis');
    $repos[] = new Config('git@github.com:skaut/SkautisNette.git', 'SkautisNette');
    $repos[] = new Config('git@github.com:skaut/SkautisBundle.git', 'SkautisBundle');

    return $repos;
}

/** @return void */
function removeDirs()
{
    shell_exec("\\rm -r api");
    shell_exec("\\rm -r docs");

    mkdir("api");
    mkdir("docs");
}

/** @return void */
function removeTmp()
{
    shell_exec("\\rm -r tmp");
}

function copyApiConfig()
{
    $configName = 'config.neon';

    if (file_exists("tmp/$configName")) {
        return;
    }

    copy("defaults/$configName", "tmp/$configName");
}

function copyDocsConfig(Config $config)
{
    $configName = 'couscous.yml';

    if (file_exists("tmp/$configName")) {
        return;
    }

    $configFile = file_get_contents("defaults/$configName");
    $configFile .= "\nbaseUrl: http://skaut.github.io/docs/{$config->getName()}";
    file_put_contents("tmp/$configName", $configFile);
}

function generateProjectDocs(Config $config)
{
    removeTmp();
    shell_exec("git clone {$config->getUrl()} tmp");

    copyApiConfig();
    $apiDir = "api/{$config->getName()}";
    shell_exec("./vendor/bin/apigen generate --source tmp --destination '$apiDir'");

    copyDocsConfig($config);
    $docsDir = "../docs/{$config->getName()}";
    echo shell_exec("cd tmp && ../vendor/bin/couscous generate --target=$docsDir");
}

function generateAll()
{
    removeDirs();
    foreach (getConfig() as $config) {
        generateProjectDocs($config);
    }
}

class Config
{
    /** @var  string */
    protected $url;

    /** @var  string */
    protected $name;

    /**
     * Config constructor.
     * @param string $url
     * @param string $name
     */
    public function __construct($url, $name)
    {
        $this->url = $url;
        $this->name = $name;
    }

    public function getUrl()
    {
        return $this->url;
    }

    public function getName()
    {
        return $this->name;
    }
}

generateAll();