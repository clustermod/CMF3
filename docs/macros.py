def typeLink(type):
    return f'<a href="https://community.bistudio.com/wiki/{type}">{type}</a>'

def define_env(env):
    "Macro Hook Fuction"

    @env.macro
    def FUNC(component, name):
        return f'cmf_{component}_fnc_{name}'
    
    @env.macro
    def FUNC_SYNTAX(parameters, component, name):
        return f'[{ ', '.join([f'<code>{ next(iter(paramData)) }</code>' for paramData in parameters]) }] call <b>cmf_{component}_fnc_{name}</b>'
    
    @env.macro
    def FUNC_PARAMS(parameters):
        return '</br>'.join([
            f'<b>{ next(iter(paramData)) }:</b> { typeLink(paramData[next(iter(paramData))]['type']) } - { paramData[next(iter(paramData))]['description'] }' for paramData in parameters
        ])

    @env.macro
    def FUNC_EXAMPLES(examples):
        return '\n'.join([f'<tr><th>Example { i + 1 }:</th> <td markdown>\n```scilab\n{ example }\n```\n</td></tr>' for i, example in enumerate(examples)])